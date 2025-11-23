# Local LLM Setup Guide

This guide covers setting up local LLM support for the claude-subagent-commands system using Ollama.

## Overview

Local LLM integration enables:
- Running agents without cloud API dependencies
- Complete data privacy (code stays local)
- Zero ongoing costs after initial setup
- Offline capability
- Custom fine-tuned models for your codebase

## Prerequisites

### Hardware Requirements

**For Inference (Running Models):**
- **Minimum**: 8GB RAM (for 7B models)
- **Recommended**: 16GB RAM (for 13B models)
- **GPU**: Optional but recommended
  - Apple Silicon (M1/M2/M3): Excellent performance
  - NVIDIA GPU: 8GB+ VRAM
  - AMD GPU: Limited support

**For Fine-Tuning:**
- **Minimum**: 16GB GPU (NVIDIA T4, RTX 3060)
- **Recommended**: 24GB+ GPU (A100, RTX 4090, RTX 3090)
- **Note**: CPU-only fine-tuning is possible but very slow

### Software Requirements

- **Operating System**: macOS, Linux, or Windows (WSL2)
- **Docker**: For containerized deployment (optional)
- **Python**: 3.8+ (for fine-tuning)
- **Git**: For cloning repositories

## Installation

### Step 1: Install Ollama

#### macOS
```bash
curl -fsSL https://ollama.com/install.sh | sh
```

Or download from: https://ollama.com/download

#### Linux
```bash
curl -fsSL https://ollama.com/install.sh | sh
```

#### Windows
Download the installer from https://ollama.com/download

Verify installation:
```bash
ollama --version
```

### Step 2: Pull Models

Pull recommended models for code tasks:

```bash
# Code generation (13B, best quality)
ollama pull codellama:13b

# Code generation (7B, faster)
ollama pull codellama:7b

# General purpose (8B)
ollama pull llama3:8b

# Fast responses (7B)
ollama pull mistral:7b

# Code-specialized (7B)
ollama pull deepseek-coder:6.7b
```

**Model sizes:**
- 7B model: ~4GB download, ~8GB RAM usage
- 13B model: ~7GB download, ~16GB RAM usage

Verify models are available:
```bash
ollama list
```

### Step 3: Install Python Dependencies

In your project directory:

```bash
pip install -r requirements.txt
```

Key dependencies:
- `ollama`: Python SDK for Ollama
- `langchain`: Provider abstraction
- `pyyaml`: Configuration management

### Step 4: Configure LLM Provider

The configuration is already set up in `config/llm_config.yaml`.

Verify configuration:
```yaml
llm:
  default_provider: ollama
  providers:
    ollama:
      enabled: true
      host: http://localhost:11434
      models:
        default: codellama:13b
```

### Step 5: Test Local LLM

Test Ollama is working:

```bash
ollama run codellama:7b "Write a Python function to calculate fibonacci"
```

Test from Python:

```python
from llm import LLMFactory

# Initialize factory
LLMFactory.initialize()

# Get Ollama provider
provider = LLMFactory.get_provider('ollama')

# Test generation
response = provider.invoke([
    {"role": "user", "content": "Write a function to validate email addresses"}
])

print(response)
```

## Usage

### Using with Existing Commands

All existing agent commands will automatically use the configured LLM provider:

```bash
# This will now use local Ollama instead of cloud API
/architecture-reviewer

# Fine-tune a model on your codebase
/fine-tune-model
```

### Switching Between Providers

To temporarily use a cloud provider:

Edit `config/llm_config.yaml`:
```yaml
llm:
  default_provider: anthropic  # Change from ollama
```

Or use task-based routing:
```yaml
task_routing:
  tech_debt_analysis: ollama.analysis
  critical_production_fix: anthropic  # Use cloud for critical tasks
```

### Checking Provider Status

```python
from llm import LLMFactory

# Check all providers
status = LLMFactory.list_providers()
print(status)
# Output: {'ollama': True, 'anthropic': False}
```

## Docker Deployment

For containerized deployment:

### Start Ollama in Docker

```bash
docker-compose up ollama
```

This starts Ollama on `http://localhost:11434`.

### Pull Models in Docker

```bash
docker exec -it claude-ollama ollama pull codellama:13b
```

### Persistent Storage

Models are stored in Docker volume `ollama_models` and persist between restarts.

## Performance Tuning

### Model Selection

Choose model based on requirements:

| Model | Size | Speed | Quality | Best For |
|-------|------|-------|---------|----------|
| mistral:7b | 4GB | Fast | Good | Quick analysis |
| codellama:7b | 4GB | Medium | Better | Code generation |
| codellama:13b | 7GB | Slower | Best | Complex tasks |
| deepseek-coder:6.7b | 4GB | Fast | Very Good | Code-specific |

### Batch Processing

For multiple independent requests:

```python
provider = LLMFactory.get_provider('ollama')

message_batches = [
    [{"role": "user", "content": "Analyze function A"}],
    [{"role": "user", "content": "Analyze function B"}],
    [{"role": "user", "content": "Analyze function C"}],
]

results = provider.batch(message_batches)
```

### Streaming Responses

For real-time output:

```python
provider = LLMFactory.get_provider('ollama')

for chunk in provider.stream([{"role": "user", "content": "Write a class..."}]):
    print(chunk, end='', flush=True)
```

## Troubleshooting

### Ollama Not Starting

**Issue**: `curl: (7) Failed to connect to localhost:11434`

**Solutions:**
1. Check if Ollama is running: `ps aux | grep ollama`
2. Start Ollama: `ollama serve`
3. Check port availability: `lsof -i :11434`

### Model Not Found

**Issue**: `model 'codellama:13b' not found`

**Solution:**
```bash
ollama pull codellama:13b
```

### Out of Memory

**Issue**: Model crashes or system freezes

**Solutions:**
1. Use smaller model: Switch from 13B to 7B
2. Close other applications
3. Increase swap space (Linux)
4. Use quantized models (GGUF format)

### Slow Performance

**Issue**: Generation takes too long

**Solutions:**
1. Use smaller/faster model (mistral:7b)
2. Reduce max_tokens in config
3. Enable GPU acceleration
4. Check CPU usage and close other apps

### Connection Refused

**Issue**: Python client can't connect to Ollama

**Solutions:**
1. Verify Ollama is running: `curl http://localhost:11434/api/tags`
2. Check firewall settings
3. Ensure correct host in config: `http://localhost:11434`

## Advanced Configuration

### Custom Model Settings

In `config/llm_config.yaml`:

```yaml
ollama:
  settings:
    temperature: 0.5  # Lower = more deterministic
    max_tokens: 4096  # Longer responses
    top_p: 0.9  # Nucleus sampling
    num_ctx: 8192  # Larger context window
```

### Multiple Model Profiles

```yaml
ollama:
  models:
    default: codellama:13b
    fast: mistral:7b
    quality: codellama:13b
    analysis: llama3:8b
    custom: my-fine-tuned-model
```

Use specific model:
```python
provider.invoke(messages, model="mistral:7b")
```

### Fallback Configuration

Automatically fallback to cloud if local fails:

```yaml
llm:
  enable_fallback: true
  fallback_provider: anthropic
```

## Next Steps

- **[Fine-Tuning Guide](fine-tuning-guide.md)**: Train custom models on your codebase
- **[Architecture Documentation](../ARCHITECTURE-LOCAL-LLM.md)**: Understand the system design
- **[API Reference](api-reference.md)**: Detailed API documentation

## Resources

- **Ollama Documentation**: https://github.com/ollama/ollama
- **Model Library**: https://ollama.com/library
- **LangChain Integration**: https://python.langchain.com/docs/integrations/llms/ollama
- **Performance Benchmarks**: https://ollama.com/blog/performance

## Getting Help

**Common Issues:**
1. Check logs: `tail -f ~/.ollama/logs/server.log`
2. Verify configuration: `cat config/llm_config.yaml`
3. Test connectivity: `curl http://localhost:11434/api/tags`

**Support:**
- GitHub Issues: https://github.com/ollama/ollama/issues
- Discord: https://discord.gg/ollama
- Documentation: https://github.com/ollama/ollama/tree/main/docs

---

**Congratulations!** You now have local LLM support configured. All agent commands will use your local models, providing fast, private, and cost-free AI assistance.
