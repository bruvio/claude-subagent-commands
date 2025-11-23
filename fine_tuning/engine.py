"""
Fine-Tuning Engine

Main orchestrator for the fine-tuning workflow:
1. Dataset generation from codebase
2. Model training with PEFT/LoRA
3. Evaluation and deployment
"""

import logging
import os
import json
from pathlib import Path
from typing import Dict, Any, Optional
import yaml

logger = logging.getLogger(__name__)


class FineTuneEngine:
    """
    Main engine for fine-tuning LLMs on project codebases.

    Orchestrates the complete workflow from dataset generation through deployment.
    """

    def __init__(self, config_path: Optional[str] = None):
        """
        Initialize fine-tuning engine.

        Args:
            config_path: Path to llm_config.yaml (uses default if None)
        """
        self.config = self._load_config(config_path)
        self.ft_config = self.config.get('fine_tuning', {})

        self.base_model = self.ft_config.get('base_model', 'codellama/CodeLlama-7b-hf')
        self.output_dir = Path(self.ft_config.get('output_dir', './models/fine-tuned'))
        self.dataset_dir = Path(self.ft_config.get('dataset_dir', './data/training'))

        # Create directories
        self.output_dir.mkdir(parents=True, exist_ok=True)
        self.dataset_dir.mkdir(parents=True, exist_ok=True)

        logger.info(f"Fine-tuning engine initialized with base model: {self.base_model}")

    def _load_config(self, config_path: Optional[str]) -> Dict[str, Any]:
        """Load configuration from YAML file."""
        if config_path is None:
            config_path = Path(__file__).parent.parent / 'config' / 'llm_config.yaml'

        with open(config_path, 'r') as f:
            return yaml.safe_load(f)

    def generate_dataset(
        self,
        codebase_path: str,
        max_examples: Optional[int] = None
    ) -> Dict[str, int]:
        """
        Generate training dataset from codebase.

        Args:
            codebase_path: Path to codebase root directory
            max_examples: Maximum number of examples to generate

        Returns:
            Dict: Statistics about generated dataset

        Note:
            Saves dataset to self.dataset_dir/dataset.json
        """
        from .dataset_generator import DatasetGenerator

        generator = DatasetGenerator(self.ft_config.get('dataset_generation', {}))

        logger.info(f"Generating dataset from {codebase_path}")
        examples = generator.generate_from_codebase(codebase_path)

        if max_examples and len(examples) > max_examples:
            examples = examples[:max_examples]

        # Split train/val
        train_split = self.ft_config.get('dataset_generation', {}).get('train_split', 0.9)
        split_idx = int(len(examples) * train_split)

        train_examples = examples[:split_idx]
        val_examples = examples[split_idx:]

        # Save datasets
        train_path = self.dataset_dir / 'train.json'
        val_path = self.dataset_dir / 'val.json'

        with open(train_path, 'w') as f:
            json.dump(train_examples, f, indent=2)

        with open(val_path, 'w') as f:
            json.dump(val_examples, f, indent=2)

        stats = {
            'total_examples': len(examples),
            'train_examples': len(train_examples),
            'val_examples': len(val_examples),
            'train_path': str(train_path),
            'val_path': str(val_path)
        }

        logger.info(f"Dataset generated: {stats}")
        return stats

    def train(self, use_docker: bool = False) -> Dict[str, Any]:
        """
        Execute fine-tuning training.

        Args:
            use_docker: Whether to run training in Docker container

        Returns:
            Dict: Training results and metrics

        Note:
            Requires dataset to be generated first.
        """
        if use_docker:
            return self._train_docker()
        else:
            return self._train_local()

    def _train_local(self) -> Dict[str, Any]:
        """
        Train model locally (not in Docker).

        Returns:
            Dict: Training results
        """
        try:
            from transformers import (
                AutoModelForCausalLM,
                AutoTokenizer,
                TrainingArguments,
                Trainer,
                DataCollatorForLanguageModeling
            )
            from peft import LoraConfig, get_peft_model, TaskType
            from datasets import load_dataset

            logger.info("Starting local training...")

            # Load tokenizer
            tokenizer = AutoTokenizer.from_pretrained(self.base_model)
            if tokenizer.pad_token is None:
                tokenizer.pad_token = tokenizer.eos_token

            # Load model
            logger.info(f"Loading base model: {self.base_model}")
            model = AutoModelForCausalLM.from_pretrained(
                self.base_model,
                load_in_4bit=True,  # QLoRA
                device_map="auto"
            )

            # Configure LoRA
            lora_config_dict = self.ft_config.get('lora_config', {})
            lora_config = LoraConfig(
                task_type=TaskType.CAUSAL_LM,
                inference_mode=False,
                r=lora_config_dict.get('r', 16),
                lora_alpha=lora_config_dict.get('lora_alpha', 32),
                lora_dropout=lora_config_dict.get('lora_dropout', 0.05),
                target_modules=lora_config_dict.get('target_modules', [
                    "q_proj", "k_proj", "v_proj", "o_proj"
                ]),
                bias=lora_config_dict.get('bias', 'none')
            )

            model = get_peft_model(model, lora_config)
            model.print_trainable_parameters()

            # Load dataset
            logger.info("Loading training dataset...")
            dataset = load_dataset(
                'json',
                data_files={
                    'train': str(self.dataset_dir / 'train.json'),
                    'validation': str(self.dataset_dir / 'val.json')
                }
            )

            # Tokenize dataset
            def tokenize_function(examples):
                # Format: instruction + input + output
                texts = []
                for i in range(len(examples['instruction'])):
                    text = f"### Instruction:\n{examples['instruction'][i]}\n\n"
                    if examples.get('input') and examples['input'][i]:
                        text += f"### Input:\n{examples['input'][i]}\n\n"
                    text += f"### Output:\n{examples['output'][i]}"
                    texts.append(text)

                return tokenizer(texts, truncation=True, max_length=512)

            tokenized_dataset = dataset.map(
                tokenize_function,
                batched=True,
                remove_columns=dataset['train'].column_names
            )

            # Training arguments
            training_config = self.ft_config.get('training', {})
            training_args = TrainingArguments(
                output_dir=str(self.output_dir),
                num_train_epochs=training_config.get('num_epochs', 3),
                per_device_train_batch_size=training_config.get('batch_size', 4),
                gradient_accumulation_steps=training_config.get('gradient_accumulation_steps', 4),
                learning_rate=training_config.get('learning_rate', 2e-4),
                fp16=training_config.get('fp16', True),
                save_steps=training_config.get('save_steps', 100),
                eval_steps=training_config.get('eval_steps', 100),
                logging_steps=training_config.get('logging_steps', 10),
                evaluation_strategy="steps",
                save_strategy="steps",
                load_best_model_at_end=True,
                warmup_steps=training_config.get('warmup_steps', 50),
                max_grad_norm=training_config.get('max_grad_norm', 1.0),
            )

            # Data collator
            data_collator = DataCollatorForLanguageModeling(
                tokenizer=tokenizer,
                mlm=False
            )

            # Trainer
            trainer = Trainer(
                model=model,
                args=training_args,
                train_dataset=tokenized_dataset['train'],
                eval_dataset=tokenized_dataset['validation'],
                data_collator=data_collator,
            )

            # Train
            logger.info("Starting training...")
            train_result = trainer.train()

            # Save model
            adapter_path = self.output_dir / 'adapter'
            model.save_pretrained(str(adapter_path))
            tokenizer.save_pretrained(str(adapter_path))

            logger.info(f"Training completed. Adapter saved to {adapter_path}")

            return {
                'success': True,
                'adapter_path': str(adapter_path),
                'metrics': train_result.metrics
            }

        except Exception as e:
            logger.error(f"Training failed: {e}", exc_info=True)
            return {
                'success': False,
                'error': str(e)
            }

    def _train_docker(self) -> Dict[str, Any]:
        """
        Train model in Docker container.

        Returns:
            Dict: Training results
        """
        import subprocess

        logger.info("Starting Docker-based training...")

        try:
            # Build Docker image
            subprocess.run(
                ['docker', 'build', '-t', 'fine-tuning', '-f', 'docker/fine-tuning.Dockerfile', '.'],
                check=True
            )

            # Run training
            subprocess.run(
                [
                    'docker', 'run',
                    '--gpus', 'all',
                    '-v', f'{self.dataset_dir}:/app/data',
                    '-v', f'{self.output_dir}:/app/models',
                    'fine-tuning'
                ],
                check=True
            )

            return {
                'success': True,
                'adapter_path': str(self.output_dir / 'adapter')
            }

        except subprocess.CalledProcessError as e:
            logger.error(f"Docker training failed: {e}")
            return {
                'success': False,
                'error': str(e)
            }

    def evaluate(self) -> Dict[str, Any]:
        """
        Evaluate fine-tuned model.

        Returns:
            Dict: Evaluation metrics and sample outputs
        """
        from .evaluator import ModelEvaluator

        evaluator = ModelEvaluator(
            self.output_dir / 'adapter',
            self.dataset_dir / 'val.json'
        )

        return evaluator.evaluate()

    def deploy_to_ollama(self, model_name: str = 'custom-project-model') -> Dict[str, Any]:
        """
        Deploy fine-tuned model to Ollama.

        Args:
            model_name: Name for the model in Ollama

        Returns:
            Dict: Deployment status
        """
        import subprocess

        logger.info(f"Deploying to Ollama as '{model_name}'...")

        try:
            # Create Modelfile
            modelfile_path = self.output_dir / 'Modelfile'
            modelfile_content = f"""FROM {str(self.output_dir / 'merged_model')}

PARAMETER temperature 0.7
PARAMETER num_ctx 4096
PARAMETER top_p 0.9

TEMPLATE \"\"\"{{{{ .System }}}}

{{{{ .Prompt }}}}\"\"\"

SYSTEM "You are a code assistant specialized in this project's patterns and architecture."
"""

            with open(modelfile_path, 'w') as f:
                f.write(modelfile_content)

            # Create Ollama model
            subprocess.run(
                ['ollama', 'create', model_name, '-f', str(modelfile_path)],
                check=True
            )

            logger.info(f"Successfully deployed model '{model_name}' to Ollama")

            return {
                'success': True,
                'model_name': model_name
            }

        except subprocess.CalledProcessError as e:
            logger.error(f"Deployment failed: {e}")
            return {
                'success': False,
                'error': str(e)
            }

    def run_full_workflow(
        self,
        codebase_path: str,
        use_docker: bool = False,
        model_name: str = 'custom-project-model'
    ) -> Dict[str, Any]:
        """
        Execute complete fine-tuning workflow.

        Args:
            codebase_path: Path to codebase for training
            use_docker: Whether to use Docker for training
            model_name: Name for deployed Ollama model

        Returns:
            Dict: Results from each stage of workflow
        """
        results = {}

        # 1. Generate dataset
        logger.info("=== Phase 1: Dataset Generation ===")
        results['dataset'] = self.generate_dataset(codebase_path)

        # 2. Train model
        logger.info("=== Phase 2: Training ===")
        results['training'] = self.train(use_docker=use_docker)

        if not results['training'].get('success'):
            logger.error("Training failed, aborting workflow")
            return results

        # 3. Evaluate
        logger.info("=== Phase 3: Evaluation ===")
        results['evaluation'] = self.evaluate()

        # 4. Deploy
        logger.info("=== Phase 4: Deployment ===")
        results['deployment'] = self.deploy_to_ollama(model_name)

        logger.info("=== Workflow Complete ===")
        return results
