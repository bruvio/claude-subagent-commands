"""
Ollama Provider Implementation

Provides local LLM capabilities using Ollama runtime.
Supports streaming, batch processing, and automatic model management.
"""

import logging
from typing import List, Dict, Any, Iterator, Optional
import ollama
from ollama import Client, ResponseError

from .provider import LLMProvider

logger = logging.getLogger(__name__)


class OllamaProvider(LLMProvider):
    """
    Ollama-based local LLM provider.

    Connects to local Ollama instance to run models like Llama, Mistral, CodeLlama, etc.
    """

    def __init__(self, config: Dict[str, Any]):
        """
        Initialize Ollama provider.

        Args:
            config: Provider configuration from llm_config.yaml
        """
        super().__init__(config)

        self.host = config.get('host', 'http://localhost:11434')
        self.client = Client(host=self.host)

        # Get model configuration
        models_config = config.get('models', {})
        self.default_model = models_config.get('default', 'codellama:13b')

        # Get default settings
        self.settings = config.get('settings', {})
        self.temperature = self.settings.get('temperature', 0.7)
        self.max_tokens = self.settings.get('max_tokens', 2048)
        self.top_p = self.settings.get('top_p', 0.9)
        self.num_ctx = self.settings.get('num_ctx', 4096)

        logger.info(f"Initialized Ollama provider at {self.host}")
        logger.info(f"Default model: {self.default_model}")

    def invoke(
        self,
        messages: List[Dict[str, str]],
        model: Optional[str] = None,
        **kwargs
    ) -> str:
        """
        Synchronous invocation of Ollama model.

        Args:
            messages: List of message dictionaries
            model: Model name override (uses default if None)
            **kwargs: Additional parameters (temperature, max_tokens, etc.)

        Returns:
            str: Generated response text

        Raises:
            ResponseError: If Ollama request fails
        """
        self.validate_messages(messages)

        model = model or self.default_model

        # Ensure model is available
        self._ensure_model_available(model)

        # Merge settings
        options = {
            'temperature': kwargs.get('temperature', self.temperature),
            'num_predict': kwargs.get('max_tokens', self.max_tokens),
            'top_p': kwargs.get('top_p', self.top_p),
            'num_ctx': kwargs.get('num_ctx', self.num_ctx),
        }

        try:
            logger.debug(f"Invoking Ollama with model {model}")
            response = self.client.chat(
                model=model,
                messages=messages,
                options=options,
                stream=False
            )

            return response['message']['content']

        except ResponseError as e:
            logger.error(f"Ollama request failed: {e}")
            raise

    def stream(
        self,
        messages: List[Dict[str, str]],
        model: Optional[str] = None,
        **kwargs
    ) -> Iterator[str]:
        """
        Streaming invocation of Ollama model.

        Args:
            messages: List of message dictionaries
            model: Model name override (uses default if None)
            **kwargs: Additional parameters

        Yields:
            str: Chunks of generated response text

        Raises:
            ResponseError: If Ollama request fails
        """
        self.validate_messages(messages)

        model = model or self.default_model

        # Ensure model is available
        self._ensure_model_available(model)

        # Merge settings
        options = {
            'temperature': kwargs.get('temperature', self.temperature),
            'num_predict': kwargs.get('max_tokens', self.max_tokens),
            'top_p': kwargs.get('top_p', self.top_p),
            'num_ctx': kwargs.get('num_ctx', self.num_ctx),
        }

        try:
            logger.debug(f"Streaming from Ollama with model {model}")
            stream = self.client.chat(
                model=model,
                messages=messages,
                options=options,
                stream=True
            )

            for chunk in stream:
                if 'message' in chunk and 'content' in chunk['message']:
                    yield chunk['message']['content']

        except ResponseError as e:
            logger.error(f"Ollama streaming failed: {e}")
            raise

    def batch(
        self,
        message_batches: List[List[Dict[str, str]]],
        model: Optional[str] = None,
        **kwargs
    ) -> List[str]:
        """
        Batch invocation of Ollama model.

        Note:
            Currently processes sequentially. Could be parallelized
            if Ollama supports concurrent requests in future.

        Args:
            message_batches: List of message lists
            model: Model name override
            **kwargs: Additional parameters

        Returns:
            List[str]: List of generated responses
        """
        model = model or self.default_model

        results = []
        for messages in message_batches:
            response = self.invoke(messages, model=model, **kwargs)
            results.append(response)

        return results

    def is_available(self) -> bool:
        """
        Check if Ollama service is running and accessible.

        Returns:
            bool: True if Ollama is reachable
        """
        try:
            # Try to list models to verify connectivity
            self.client.list()
            return True
        except Exception as e:
            logger.warning(f"Ollama not available: {e}")
            return False

    def get_model_info(self) -> Dict[str, Any]:
        """
        Get information about the current default model.

        Returns:
            Dict: Model metadata from Ollama
        """
        try:
            models = self.client.list()

            # Find current model in list
            for model in models.get('models', []):
                if model['name'] == self.default_model:
                    return {
                        'name': model['name'],
                        'size': model.get('size'),
                        'modified_at': model.get('modified_at'),
                        'details': model.get('details', {}),
                    }

            # Model not found in list
            return {
                'name': self.default_model,
                'available': False,
                'message': 'Model not pulled yet'
            }

        except Exception as e:
            logger.error(f"Failed to get model info: {e}")
            return {'error': str(e)}

    def _ensure_model_available(self, model: str) -> None:
        """
        Ensure model is pulled and available locally.

        Args:
            model: Model name to check

        Raises:
            ResponseError: If model pull fails
        """
        try:
            models = self.client.list()
            available_models = [m['name'] for m in models.get('models', [])]

            if model not in available_models:
                logger.info(f"Model {model} not found locally. Pulling...")
                self.client.pull(model)
                logger.info(f"Successfully pulled model {model}")

        except ResponseError as e:
            logger.error(f"Failed to ensure model availability: {e}")
            raise

    def list_available_models(self) -> List[str]:
        """
        Get list of all locally available models.

        Returns:
            List[str]: List of model names
        """
        try:
            models = self.client.list()
            return [m['name'] for m in models.get('models', [])]
        except Exception as e:
            logger.error(f"Failed to list models: {e}")
            return []

    def pull_model(self, model: str) -> None:
        """
        Explicitly pull a model from Ollama registry.

        Args:
            model: Model name to pull

        Raises:
            ResponseError: If pull fails
        """
        logger.info(f"Pulling model {model}...")
        self.client.pull(model)
        logger.info(f"Successfully pulled {model}")

    def delete_model(self, model: str) -> None:
        """
        Delete a model from local storage.

        Args:
            model: Model name to delete

        Raises:
            ResponseError: If deletion fails
        """
        logger.info(f"Deleting model {model}...")
        self.client.delete(model)
        logger.info(f"Successfully deleted {model}")
