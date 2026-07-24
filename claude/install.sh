#!/usr/bin/env bash
#
# Install and configure Claude Code CLI

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

echo "› Linking Claude Code user configuration..."
link_managed_path "$DOTFILES/claude/settings.json" "$HOME/.claude/settings.json"
link_managed_path "$DOTFILES/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
mkdir -p "$HOME/.claude/agents" "$HOME/.claude/hooks" "$HOME/.claude/skills"

for agent_src in "$DOTFILES"/claude/agents/*.md; do
    [[ -f "$agent_src" ]] || continue
    link_managed_path "$agent_src" "$HOME/.claude/agents/$(basename "$agent_src")"
done

for hook_src in "$DOTFILES"/claude/hooks/*; do
    [[ -f "$hook_src" ]] || continue
    link_managed_path "$hook_src" "$HOME/.claude/hooks/$(basename "$hook_src")"
done

for skill_src in "$DOTFILES"/claude/skills/*; do
    [[ -d "$skill_src" ]] || continue
    link_managed_path "$skill_src" "$HOME/.claude/skills/$(basename "$skill_src")"
done

AZURE_SKILLS=(
    airunway-aks-setup
    appinsights-instrumentation
    azure-aigateway
    azure-compliance
    azure-diagnostics
    azure-enterprise-infra-planner
    azure-kubernetes
    azure-kusto
    azure-messaging
    azure-quotas
    azure-rbac
    azure-reliability
    azure-resource-lookup
    azure-resource-visualizer
    entra-agent-id
    entra-app-registration
    python-appservice-deploy
)

for skill_name in "${AZURE_SKILLS[@]}"; do
    skill_src="$HOME/.agents/skills/$skill_name"
    if [[ -d "$skill_src" ]]; then
        link_managed_path "$skill_src" "$HOME/.claude/skills/$skill_name"
    else
        echo "  Skipping unavailable Azure skill: $skill_name"
    fi
done

echo ""
echo "  ┌─────────────────────────────────────────────────────────────────┐"
echo "  │  Next step: Authenticate Claude Code                           │"
echo "  │                                                                 │"
echo "  │  Run: claude                                                    │"
echo "  │  A browser window will open to complete sign-in.               │"
echo "  └─────────────────────────────────────────────────────────────────┘"
echo ""
echo "  Claude Code setup complete."
