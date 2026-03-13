#!/usr/bin/env bash
#
# Install and configure Gemini CLI

set -e

echo "› Setting up Gemini CLI..."

# Install Gemini CLI via npm
if ! command -v gemini &>/dev/null; then
    echo "  Installing Gemini CLI..."
    npm install -g @google/gemini-cli
    echo "  Gemini CLI installed successfully."
else
    echo "  Gemini CLI already installed."
fi

# Remind user about API key setup
if [ -z "$GEMINI_API_KEY" ]; then
    echo ""
    echo "  ┌─────────────────────────────────────────────────────────────────┐"
    echo "  │  Next step: Authenticate Gemini CLI                            │"
    echo "  │                                                                 │"
    echo "  │  Option 1 (recommended): Run 'gemini' and follow the prompts   │"
    echo "  │  Option 2: Add to ~/.zshrc.local:                              │"
    echo "  │    export GEMINI_API_KEY='your-api-key-here'                   │"
    echo "  │                                                                 │"
    echo "  │  Get your API key at: https://aistudio.google.com/apikey       │"
    echo "  └─────────────────────────────────────────────────────────────────┘"
    echo ""
fi

echo "  Gemini setup complete. Run 'gemini' to start."
