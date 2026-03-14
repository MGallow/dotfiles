#!/usr/bin/env bash
#
# Install Homebrew and all packages from the Brewfile.
# Safe to re-run: skips installation if already present, uses `brew bundle --no-upgrade`
# on first install so an existing Mac backup isn't mass-upgraded unexpectedly.

set -e

# Resolve dotfiles root relative to this script so the Brewfile path works
# whether or not $DOTFILES is already exported in the environment.
DOTFILES="${DOTFILES:-$(cd "$(dirname "$0")/.." && pwd)}"

# ── Homebrew ──────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
    echo "  Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Apple Silicon: add brew to PATH for this session and persist to .zprofile
    if [[ "$(uname -m)" == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "  Homebrew already installed: $(brew --version | head -1)"
fi

# ── Brewfile ──────────────────────────────────────────────────────────────────
brew update

# Resolve Brewfile location: prefer $DOTFILES env var, fall back to ~/.dotfiles
BREWFILE="${DOTFILES:-$HOME/.dotfiles}/Brewfile"

# `--no-upgrade` means: install missing packages but don't upgrade ones that are
# already present (important when restoring from a backup — avoids mass upgrades).
# Run `brew upgrade` separately or via `dot update` when you want to upgrade.
if [[ "${DOTFILES_CI:-}" == "1" ]]; then
    echo "  CI mode: skipping casks and mas (formulae only)"
    brew bundle install --file="$BREWFILE" --no-upgrade --no-lock --verbose --no-cask --no-mas
else
    brew bundle install --file="$BREWFILE" --no-upgrade
fi

brew cleanup
