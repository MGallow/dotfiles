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

echo ""
echo "  ┌─────────────────────────────────────────────────────────────────┐"
echo "  │  Next step: Authenticate Claude Code                           │"
echo "  │                                                                 │"
echo "  │  Run: claude                                                    │"
echo "  │  A browser window will open to complete sign-in.               │"
echo "  └─────────────────────────────────────────────────────────────────┘"
echo ""
echo "  Claude Code setup complete."
