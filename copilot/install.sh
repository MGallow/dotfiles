#!/usr/bin/env bash
#
# Install and configure GitHub Copilot user-level hooks.
# Symlinks ~/.copilot/hooks/ → dotfiles/copilot/hooks/ so hook scripts
# are version-controlled and persist across machines.

set -e

DOTFILES="${DOTFILES:-$(cd "$(dirname "$0")"/.. && pwd)}"
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
