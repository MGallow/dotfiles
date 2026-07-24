#!/usr/bin/env bash
#
# Install and configure OpenAI Codex CLI

set -euo pipefail

DOTFILES="${DOTFILES:-$(cd "$(dirname "$0")"/.. && pwd)}"

link_managed_path() {
    local src=$1
    local dst=$2

    mkdir -p "$(dirname "$dst")"

    if [[ -e "$dst" || -L "$dst" ]]; then
        if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
            echo "  Already linked $dst"
            return
        fi

        local backup="${dst}.backup"
        if [[ -e "$backup" || -L "$backup" ]]; then
            backup="${dst}.backup.$(date +%Y%m%d%H%M%S)"
        fi
        echo "  Backing up $dst to $backup"
        mv "$dst" "$backup"
    fi

    ln -s "$src" "$dst"
    echo "  Linked $dst → $src"
}

remove_managed_link() {
    local dst=$1
    local expected_prefix=$2

    if [[ -L "$dst" && "$(readlink "$dst")" == "$expected_prefix"* ]]; then
        rm "$dst"
        echo "  Removed obsolete link $dst"
    fi
}

echo "› Setting up OpenAI Codex CLI..."

# Install Codex CLI via the official Homebrew cask
if ! command -v codex &>/dev/null || ! codex --version &>/dev/null; then
    echo "  Installing OpenAI Codex CLI..."
    brew install --cask codex
    echo "  OpenAI Codex CLI installed successfully."
else
    echo "  OpenAI Codex CLI already installed."
fi

echo "› Linking OpenAI Codex user configuration..."
mkdir -p "$HOME/.codex"
link_managed_path "$DOTFILES/openai/config.toml" "$HOME/.codex/config.toml"
link_managed_path "$DOTFILES/openai/AGENTS.md" "$HOME/.codex/AGENTS.md"
mkdir -p "$HOME/.codex/agents"

for agent_src in "$DOTFILES"/openai/agents/*.toml; do
    [[ -f "$agent_src" ]] || continue
    link_managed_path "$agent_src" "$HOME/.codex/agents/$(basename "$agent_src")"
done

mkdir -p "$HOME/.codex/skills"
for skill_src in "$DOTFILES"/openai/skills/*; do
    [[ -d "$skill_src" ]] || continue
    link_managed_path "$skill_src" "$HOME/.codex/skills/$(basename "$skill_src")"
done

remove_managed_link "$HOME/.codex/hooks.json" "$DOTFILES/openai/hooks.json"
remove_managed_link "$HOME/.codex/hooks/ruff-autoformat.sh" "$DOTFILES/openai/hooks/"

for skill_name in commit refactor review-code write-tests finalize; do
    remove_managed_link "$HOME/.agents/skills/$skill_name" "$DOTFILES/openai/skills/$skill_name"
done

# Remind unauthenticated users about native sign-in
if ! codex login status &>/dev/null && [[ -z "${OPENAI_API_KEY:-}" ]]; then
    echo ""
    echo "  ┌─────────────────────────────────────────────────────────────────┐"
    echo "  │  Next step: Authenticate Codex CLI                             │"
    echo "  │                                                                 │"
    echo "  │  Run: codex login                                               │"
    echo "  │  A browser window will open to complete ChatGPT sign-in.       │"
    echo "  │                                                                 │"
    echo "  │  OPENAI_API_KEY remains available as an alternative.           │"
    echo "  └─────────────────────────────────────────────────────────────────┘"
    echo ""
fi

echo "  OpenAI Codex setup complete. Run 'codex' to start."
