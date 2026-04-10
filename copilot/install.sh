#!/usr/bin/env bash
#
# Install and configure GitHub Copilot user-level hooks and prompts.
# Symlinks ~/.copilot/hooks/ → dotfiles/copilot/hooks/ and the VS Code
# user prompts folder → dotfiles/copilot/prompts/ so instructions, agents,
# and prompts are version-controlled and persist across machines.

set -e

DOTFILES="${DOTFILES:-$(cd "$(dirname "$0")"/.. && pwd)}"

# ---------------------------------------------------------------------------
# Hooks  (~/.copilot/hooks/)
# ---------------------------------------------------------------------------
HOOK_SRC="$DOTFILES/copilot/hooks"
HOOK_DST="$HOME/.copilot/hooks"

echo "› Setting up Copilot hooks..."

# Ensure parent directory exists
mkdir -p "$HOME/.copilot"

# If the destination is a real directory (not a symlink), back it up
if [ -d "$HOOK_DST" ] && [ ! -L "$HOOK_DST" ]; then
    echo "  Backing up existing hooks to ${HOOK_DST}.backup"
    mv "$HOOK_DST" "${HOOK_DST}.backup"
fi

# Remove existing symlink if present (idempotent)
if [ -L "$HOOK_DST" ]; then
    rm "$HOOK_DST"
fi

# Create the symlink
ln -s "$HOOK_SRC" "$HOOK_DST"
echo "  Linked $HOOK_DST → $HOOK_SRC"

echo "  Copilot hooks setup complete."

# ---------------------------------------------------------------------------
# User-level prompts (VS Code user prompts folder)
# ---------------------------------------------------------------------------
PROMPTS_SRC="$DOTFILES/copilot/prompts"

# Detect the VS Code prompts folder (Insiders vs stable)
if [ -d "$HOME/Library/Application Support/Code - Insiders/User" ]; then
    PROMPTS_DST="$HOME/Library/Application Support/Code - Insiders/User/prompts"
elif [ -d "$HOME/Library/Application Support/Code/User" ]; then
    PROMPTS_DST="$HOME/Library/Application Support/Code/User/prompts"
elif [ -d "$HOME/.config/Code - Insiders/User" ]; then
    PROMPTS_DST="$HOME/.config/Code - Insiders/User/prompts"
elif [ -d "$HOME/.config/Code/User" ]; then
    PROMPTS_DST="$HOME/.config/Code/User/prompts"
else
    echo "  ⚠ Could not locate VS Code user folder — skipping prompts setup."
    exit 0
fi

echo "› Setting up Copilot user prompts..."

# If the destination is a real directory (not a symlink), back it up
if [ -d "$PROMPTS_DST" ] && [ ! -L "$PROMPTS_DST" ]; then
    echo "  Backing up existing prompts to ${PROMPTS_DST}.backup"
    mv "$PROMPTS_DST" "${PROMPTS_DST}.backup"
fi

# Remove existing symlink if present (idempotent)
if [ -L "$PROMPTS_DST" ]; then
    rm "$PROMPTS_DST"
fi

# Create the symlink
ln -s "$PROMPTS_SRC" "$PROMPTS_DST"
echo "  Linked $PROMPTS_DST → $PROMPTS_SRC"

echo "  Copilot user prompts setup complete."
