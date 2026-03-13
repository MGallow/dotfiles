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

echo ""
echo "  ┌─────────────────────────────────────────────────────────────────┐"
echo "  │  Next step: Authenticate Gemini CLI                            │"
echo "  │                                                                 │"
echo "  │  Run: gemini                                                    │"
echo "  │  A browser window will open to sign in with your Google        │"
echo "  │  account (no API key required).                                │"
echo "  └─────────────────────────────────────────────────────────────────┘"
echo ""
echo "  Gemini setup complete."
