"""
LLM Provider Factory

Creates and manages LLM provider instances based on configuration.
Handles provider selection, fallback, and task routing.
"""

import logging
from typing import Dict, Any, Optional
from .provider import LLMProvider
from .ollama_provider import OllamaProvider
from .config_loader import load_llm_config, get_provider_config, get_model_for_task

logger = logging.getLogger(__name__)


class LLMFactory:
    """
    Factory for creating and managing LLM providers.

    Handles provider initialization, caching, and fallback logic.
    """

    _providers: Dict[str, LLMProvider] = {}
    _config: Optional[Dict[str, Any]] = None

    @classmethod
    def initialize(cls, config_path: Optional[str] = None) -> None:
        """
        Initialize the factory with configuration.

        Args:
            config_path: Path to configuration file (uses default if None)
        """
        cls._config = load_llm_config(config_path)
        logger.info("LLM Factory initialized")

    @classmethod
    def get_provider(
        cls,
        provider_name: Optional[str] = None,
        task_name: Optional[str] = None
    ) -> LLMProvider:
        """
        Get a provider instance.

        Args:
            provider_name: Specific provider name (e.g., 'ollama', 'anthropic')
            task_name: Task name for automatic routing (e.g., 'code_generation')

        Returns:
            LLMProvider: Provider instance

        Raises:
            ValueError: If configuration not initialized or provider invalid

        Note:
            If both provider_name and task_name are None, returns default provider.
            If task_name is specified, uses task routing from configuration.
            If provider_name is specified, uses that provider directly.
        """
        if cls._config is None:
            cls.initialize()

        # Determine which provider to use
        if provider_name is None:
            if task_name is not None:
                # Use task routing
                provider_name, _ = get_model_for_task(cls._config, task_name)
                logger.debug(f"Task '{task_name}' routed to provider '{provider_name}'")
            else:
                # Use default provider
                provider_name = cls._config['llm']['default_provider']

        # Check if provider is cached
        if provider_name in cls._providers:
            return cls._providers[provider_name]

        # Create new provider instance
        provider = cls._create_provider(provider_name)
        cls._providers[provider_name] = provider

        return provider

    @classmethod
    def _create_provider(cls, provider_name: str) -> LLMProvider:
        """
        Create a new provider instance.

        Args:
            provider_name: Name of provider to create

        Returns:
            LLMProvider: New provider instance

        Raises:
            ValueError: If provider type is unknown
        """
        provider_config = get_provider_config(cls._config, provider_name)

        if provider_name == 'ollama':
            return OllamaProvider(provider_config)
        elif provider_name == 'anthropic':
            # Import here to avoid circular dependency
            from .anthropic_provider import AnthropicProvider
            return AnthropicProvider(provider_config)
        else:
            raise ValueError(f"Unknown provider type: {provider_name}")

    @classmethod
    def get_provider_with_fallback(
        cls,
        primary_provider: Optional[str] = None,
        task_name: Optional[str] = None
    ) -> LLMProvider:
        """
        Get provider with automatic fallback on failure.

        Args:
            primary_provider: Primary provider to try
            task_name: Task name for routing

        Returns:
            LLMProvider: Available provider (primary or fallback)

        Note:
            If primary provider is unavailable and fallback is enabled,
            returns fallback provider instead.
        """
        if cls._config is None:
            cls.initialize()

        # Get primary provider
        provider = cls.get_provider(primary_provider, task_name)

        # Check if provider is available
        if provider.is_available():
            return provider

        # Try fallback if enabled
        if cls._config['llm'].get('enable_fallback', False):
            fallback_name = cls._config['llm'].get('fallback_provider')
            if fallback_name and fallback_name != primary_provider:
                logger.warning(
                    f"Primary provider unavailable, falling back to {fallback_name}"
                )
                fallback_provider = cls.get_provider(fallback_name)
                if fallback_provider.is_available():
                    return fallback_provider

        # No fallback available, return primary anyway (will fail on use)
        logger.error("No available providers found")
        return provider

    @classmethod
    def reset(cls) -> None:
        """
        Reset factory state (useful for testing).

        Clears cached providers and configuration.
        """
        cls._providers.clear()
        cls._config = None
        logger.info("LLM Factory reset")

    @classmethod
    def get_config(cls) -> Dict[str, Any]:
        """
        Get current configuration.

        Returns:
            Dict: Current LLM configuration

        Raises:
            ValueError: If factory not initialized
        """
        if cls._config is None:
            raise ValueError("Factory not initialized. Call initialize() first.")
        return cls._config

    @classmethod
    def list_providers(cls) -> Dict[str, bool]:
        """
        List all configured providers and their availability.

        Returns:
            Dict: Provider names mapped to availability status
        """
        if cls._config is None:
            cls.initialize()

        providers_config = cls._config['llm']['providers']
        status = {}

        for provider_name in providers_config.keys():
            if providers_config[provider_name].get('enabled', False):
                try:
                    provider = cls.get_provider(provider_name)
                    status[provider_name] = provider.is_available()
                except Exception as e:
                    logger.error(f"Error checking {provider_name}: {e}")
                    status[provider_name] = False
            else:
                status[provider_name] = False

        return status
