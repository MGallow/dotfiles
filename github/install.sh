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
# Note: newer gh versions ship copilot as a built-in; extension install is skipped in that case.
if gh extension list 2>/dev/null | grep -q "github/gh-copilot"; then
    echo "  GitHub Copilot CLI extension already installed — upgrading..."
    gh extension upgrade github/gh-copilot 2>/dev/null || echo "  Already at latest."
elif gh copilot --version &>/dev/null 2>&1; then
    echo "  GitHub Copilot is available as a built-in gh command — no extension needed."
else
    echo "  Installing GitHub Copilot CLI extension..."
    gh extension install github/gh-copilot 2>&1 || echo "  Skipped (may require gh auth login first)."
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
