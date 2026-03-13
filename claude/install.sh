#!/usr/bin/env bash
#
# Install and configure Claude Code CLI

set -e

echo "› Setting up Claude Code CLI..."

# Install Claude Code CLI via npm
if ! command -v claude &>/dev/null; then
    echo "  Installing Claude Code CLI..."
    npm install -g @anthropic-ai/claude-code
    echo "  Claude Code CLI installed successfully."
else
    echo "  Claude Code CLI already installed: $(claude --version 2>/dev/null || echo 'installed')"
fi

# Create Claude config directory
mkdir -p "$HOME/.claude"

# Remind user about API key setup
if [ -z "$ANTHROPIC_API_KEY" ]; then
    echo ""
    echo "  ┌─────────────────────────────────────────────────────────────────┐"
    echo "  │  Next step: Authenticate Claude Code                           │"
    echo "  │                                                                 │"
    echo "  │  Option 1 (recommended): Run 'claude' and follow the prompts   │"
    echo "  │  Option 2: Add to ~/.zshrc.local:                              │"
    echo "  │    export ANTHROPIC_API_KEY='your-api-key-here'                │"
    echo "  │                                                                 │"
    echo "  │  Get your API key at: https://console.anthropic.com            │"
    echo "  └─────────────────────────────────────────────────────────────────┘"
    echo ""
fi

echo "  Claude Code setup complete. Run 'claude' to start."
