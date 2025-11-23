"""
Base LLM Provider Interface

Defines the abstract interface that all LLM providers must implement.
This ensures consistent behavior across local (Ollama) and cloud (Anthropic) providers.
"""

from abc import ABC, abstractmethod
from typing import List, Dict, Any, Iterator, Optional


class LLMProvider(ABC):
    """
    Abstract base class for LLM providers.

    All providers (Ollama, Anthropic, etc.) must implement this interface
    to ensure consistent behavior across the multi-agent system.
    """

    def __init__(self, config: Dict[str, Any]):
        """
        Initialize the LLM provider with configuration.

        Args:
            config: Provider-specific configuration dictionary
        """
        self.config = config

    @abstractmethod
    def invoke(self, messages: List[Dict[str, str]], **kwargs) -> str:
        """
        Synchronous invocation of the LLM.

        Args:
            messages: List of message dictionaries with 'role' and 'content' keys
            **kwargs: Additional provider-specific parameters

        Returns:
            str: Generated response text

        Raises:
            Exception: If the request fails
        """
        pass

    @abstractmethod
    def stream(self, messages: List[Dict[str, str]], **kwargs) -> Iterator[str]:
        """
        Streaming invocation of the LLM.

        Args:
            messages: List of message dictionaries with 'role' and 'content' keys
            **kwargs: Additional provider-specific parameters

        Yields:
            str: Chunks of generated response text

        Raises:
            Exception: If the request fails
        """
        pass

    @abstractmethod
    def batch(
        self,
        message_batches: List[List[Dict[str, str]]],
        **kwargs
    ) -> List[str]:
        """
        Batch invocation of the LLM for multiple independent requests.

        Args:
            message_batches: List of message lists for parallel processing
            **kwargs: Additional provider-specific parameters

        Returns:
            List[str]: List of generated responses

        Raises:
            Exception: If the request fails
        """
        pass

    @abstractmethod
    def is_available(self) -> bool:
        """
        Check if the provider is currently available.

        Returns:
            bool: True if provider is reachable and functional

        Note:
            For local providers (Ollama), checks if service is running.
            For cloud providers, checks API connectivity.
        """
        pass

    @abstractmethod
    def get_model_info(self) -> Dict[str, Any]:
        """
        Get information about the current model.

        Returns:
            Dict: Model metadata (name, size, capabilities, etc.)
        """
        pass

    def validate_messages(self, messages: List[Dict[str, str]]) -> None:
        """
        Validate message format before sending to LLM.

        Args:
            messages: List of message dictionaries

        Raises:
            ValueError: If messages format is invalid
        """
        if not messages:
            raise ValueError("Messages list cannot be empty")

        for msg in messages:
            if not isinstance(msg, dict):
                raise ValueError(f"Message must be a dict, got {type(msg)}")

            if 'role' not in msg:
                raise ValueError("Message must have 'role' field")

            if 'content' not in msg:
                raise ValueError("Message must have 'content' field")

            valid_roles = ['system', 'user', 'assistant']
            if msg['role'] not in valid_roles:
                raise ValueError(
                    f"Invalid role '{msg['role']}'. Must be one of {valid_roles}"
                )
