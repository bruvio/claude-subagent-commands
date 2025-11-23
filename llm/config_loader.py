"""
Configuration Loader for LLM Providers

Loads and validates LLM configuration from YAML files with environment variable substitution.
"""

import os
import re
import yaml
from typing import Dict, Any
from pathlib import Path


def load_llm_config(config_path: str = None) -> Dict[str, Any]:
    """
    Load LLM configuration from YAML file.

    Args:
        config_path: Path to configuration file. If None, uses default location.

    Returns:
        Dict: Loaded and validated configuration

    Raises:
        FileNotFoundError: If configuration file doesn't exist
        yaml.YAMLError: If YAML parsing fails
    """
    if config_path is None:
        # Default to config/llm_config.yaml relative to project root
        config_path = Path(__file__).parent.parent / 'config' / 'llm_config.yaml'

    config_path = Path(config_path)
    if not config_path.exists():
        raise FileNotFoundError(f"Configuration file not found: {config_path}")

    # Load YAML
    with open(config_path, 'r') as f:
        config = yaml.safe_load(f)

    # Substitute environment variables
    config = substitute_env_vars(config)

    # Validate configuration
    validate_config(config)

    return config


def substitute_env_vars(config: Any) -> Any:
    """
    Recursively substitute environment variables in configuration.

    Supports ${VAR_NAME} and ${VAR_NAME:default} syntax.

    Args:
        config: Configuration object (dict, list, or primitive)

    Returns:
        Configuration with environment variables substituted
    """
    if isinstance(config, dict):
        return {k: substitute_env_vars(v) for k, v in config.items()}

    elif isinstance(config, list):
        return [substitute_env_vars(item) for item in config]

    elif isinstance(config, str):
        # Match ${VAR_NAME} or ${VAR_NAME:default}
        pattern = r'\$\{([^:}]+)(?::([^}]*))?\}'

        def replacer(match):
            var_name = match.group(1)
            default_value = match.group(2) if match.group(2) is not None else ''
            return os.getenv(var_name, default_value)

        return re.sub(pattern, replacer, config)

    else:
        return config


def validate_config(config: Dict[str, Any]) -> None:
    """
    Validate LLM configuration structure.

    Args:
        config: Configuration dictionary

    Raises:
        ValueError: If configuration is invalid
    """
    # Check required top-level keys
    if 'llm' not in config:
        raise ValueError("Configuration must have 'llm' section")

    llm_config = config['llm']

    # Check required fields
    required_fields = ['default_provider', 'providers']
    for field in required_fields:
        if field not in llm_config:
            raise ValueError(f"LLM configuration must have '{field}' field")

    # Validate default provider exists
    default_provider = llm_config['default_provider']
    if default_provider not in llm_config['providers']:
        raise ValueError(
            f"Default provider '{default_provider}' not found in providers"
        )

    # Validate fallback provider if specified
    if 'fallback_provider' in llm_config:
        fallback_provider = llm_config['fallback_provider']
        if fallback_provider not in llm_config['providers']:
            raise ValueError(
                f"Fallback provider '{fallback_provider}' not found in providers"
            )

    # Validate provider configurations
    for provider_name, provider_config in llm_config['providers'].items():
        if not isinstance(provider_config, dict):
            raise ValueError(
                f"Provider '{provider_name}' configuration must be a dictionary"
            )

        if 'enabled' not in provider_config:
            raise ValueError(
                f"Provider '{provider_name}' must have 'enabled' field"
            )


def get_provider_config(
    config: Dict[str, Any],
    provider_name: str
) -> Dict[str, Any]:
    """
    Get configuration for a specific provider.

    Args:
        config: Full LLM configuration
        provider_name: Name of provider (e.g., 'ollama', 'anthropic')

    Returns:
        Dict: Provider-specific configuration

    Raises:
        ValueError: If provider not found or disabled
    """
    llm_config = config['llm']

    if provider_name not in llm_config['providers']:
        raise ValueError(f"Provider '{provider_name}' not found in configuration")

    provider_config = llm_config['providers'][provider_name]

    if not provider_config.get('enabled', False):
        raise ValueError(f"Provider '{provider_name}' is disabled")

    return provider_config


def get_model_for_task(
    config: Dict[str, Any],
    task_name: str
) -> tuple[str, str]:
    """
    Get the appropriate model for a specific task.

    Args:
        config: Full LLM configuration
        task_name: Name of task (e.g., 'code_generation', 'architecture_review')

    Returns:
        tuple: (provider_name, model_name)

    Note:
        Returns default provider/model if task not in routing table.
    """
    llm_config = config['llm']
    task_routing = llm_config.get('task_routing', {})

    if task_name not in task_routing:
        # Use default provider and model
        provider_name = llm_config['default_provider']
        provider_config = llm_config['providers'][provider_name]
        model_name = provider_config.get('models', {}).get('default')
        return provider_name, model_name

    # Parse routing entry (e.g., "ollama.code_generation" or "anthropic")
    routing = task_routing[task_name]

    if '.' in routing:
        # Format: provider.model_key
        provider_name, model_key = routing.split('.', 1)
        provider_config = llm_config['providers'][provider_name]
        model_name = provider_config.get('models', {}).get(model_key)
    else:
        # Format: provider (use provider's default model)
        provider_name = routing
        provider_config = llm_config['providers'][provider_name]
        model_name = provider_config.get('model')

    return provider_name, model_name
