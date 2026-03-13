#!/usr/bin/env bash
#
# Set up GitHub CLI and GitHub Copilot CLI extension

set -e

echo "› Setting up GitHub CLI..."

if ! command -v gh &>/dev/null; then
    echo "  GitHub CLI not found. Install it with: brew install gh"
    exit 1
fi

echo "  GitHub CLI found: $(gh --version | head -1)"

# Install GitHub Copilot CLI extension
if ! gh extension list 2>/dev/null | grep -q "github/gh-copilot"; then
    echo "  Installing GitHub Copilot CLI extension..."
    gh extension install github/gh-copilot
    echo "  GitHub Copilot CLI extension installed."
else
    echo "  GitHub Copilot CLI extension already installed."
fi

# Check authentication status
if ! gh auth status &>/dev/null; then
    echo ""
    echo "  ┌─────────────────────────────────────────────────────────────────┐"
    echo "  │  Next step: Authenticate GitHub CLI                            │"
    echo "  │                                                                 │"
    echo "  │  Run: gh auth login                                             │"
    echo "  │                                                                 │"
    echo "  │  Then use Copilot in your terminal:                            │"
    echo "  │    gh copilot suggest 'how do I undo last git commit'          │"
    echo "  │    gh copilot explain 'git rebase -i HEAD~3'                   │"
    echo "  └─────────────────────────────────────────────────────────────────┘"
    echo ""
else
    echo "  GitHub CLI already authenticated."
fi

echo "  GitHub CLI setup complete."
