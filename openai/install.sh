#!/usr/bin/env bash
#
# Install and configure OpenAI Codex CLI

set -e

echo "› Setting up OpenAI Codex CLI..."

# Install Codex CLI via npm
if ! command -v codex &>/dev/null; then
    echo "  Installing OpenAI Codex CLI..."
    npm install -g @openai/codex
    echo "  OpenAI Codex CLI installed successfully."
else
    echo "  OpenAI Codex CLI already installed."
fi

# Remind user about API key setup
if [ -z "$OPENAI_API_KEY" ]; then
    echo ""
    echo "  ┌─────────────────────────────────────────────────────────────────┐"
    echo "  │  Next step: Authenticate Codex CLI                             │"
    echo "  │                                                                 │"
    echo "  │  Add to ~/.zshrc.local:                                        │"
    echo "  │    export OPENAI_API_KEY='sk-...'                              │"
    echo "  │                                                                 │"
    echo "  │  Get your API key at: https://platform.openai.com/api-keys     │"
    echo "  └─────────────────────────────────────────────────────────────────┘"
    echo ""
fi

echo "  OpenAI Codex setup complete. Run 'codex' to start."
