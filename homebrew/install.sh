#!/usr/bin/env bash
#
# Install Homebrew and all packages from the Brewfile.
# - Formulae: installed and upgraded if outdated.
# - Casks tracked by Homebrew: installed and upgraded if outdated.
# - Casks installed outside Homebrew (e.g. from backup/DMG): skipped entirely.

set -e

# Resolve dotfiles root relative to this script so the Brewfile path works
# whether or not $DOTFILES is already exported in the environment.
DOTFILES="${DOTFILES:-$(cd "$(dirname "$0")/.." && pwd)}"

# ── Homebrew ──────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
    echo "  Installing Homebrew..."
    # Security note: This runs the official Homebrew installer from GitHub.
    # Source: https://github.com/Homebrew/install/blob/HEAD/install.sh
    # Alternative: follow manual instructions at https://brew.sh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Apple Silicon: add brew to PATH for this session and persist to .zprofile
    if [[ "$(uname -m)" == "arm64" ]]; then
        grep -qF 'brew shellenv' "$HOME/.zprofile" 2>/dev/null || \
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "  Homebrew already installed: $(brew --version | head -1)"
fi

# ── Brewfile ──────────────────────────────────────────────────────────────────
arch -arm64 brew update

if [[ "${DOTFILES_CI:-}" == "1" ]]; then
    echo "  CI mode: installing formulae directly (skipping brew bundle to avoid tap issues)"
    # brew bundle triggers a deprecated homebrew/bundle tap on some Homebrew versions.
    # Parsing the Brewfile ourselves and calling brew install avoids that entirely.
    grep -E '^brew ' "$DOTFILES/Brewfile" \
        | sed 's/brew "\([^"]*\)".*/\1/' \
        | xargs brew install --formula 2>&1
else
    # Skip casks not currently tracked by Homebrew (installed outside it, e.g.
    # from a DMG or restored from backup). Formulae and Homebrew-tracked casks
    # are installed and upgraded normally.
    TRACKED_CASKS=$(arch -arm64 brew list --cask 2>/dev/null)
    SKIP_CASKS=""
    while IFS= read -r line; do
        cask=$(echo "$line" | sed 's/^cask "\([^"]*\)".*/\1/')
        if ! echo "$TRACKED_CASKS" | grep -qx "$cask"; then
            SKIP_CASKS="${SKIP_CASKS:+$SKIP_CASKS }$cask"
        fi
    done < <(grep '^cask ' "$DOTFILES/Brewfile")

    HOMEBREW_BUNDLE_CASK_SKIP="$SKIP_CASKS" \
        arch -arm64 brew bundle install --file="$DOTFILES/Brewfile" || {
            echo "  [WARN] brew bundle reported failures — continuing anyway"
        }
fi

arch -arm64 brew cleanup
