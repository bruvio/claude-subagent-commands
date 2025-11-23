"""
LLM Provider Abstraction Layer

This module provides a unified interface for interacting with different LLM providers,
supporting both local models (via Ollama) and cloud providers (Anthropic, OpenAI, etc.).
"""

from .provider import LLMProvider
from .factory import LLMFactory
from .config_loader import load_llm_config

__all__ = ['LLMProvider', 'LLMFactory', 'load_llm_config']
