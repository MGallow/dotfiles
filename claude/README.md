# Claude Code Configuration

This topic mirrors portable user-level Copilot behavior through documented Claude Code configuration surfaces.

The managed settings are additive: they do not pin a model, change permission mode, force sandbox behavior, limit tools, or disable native Claude Code capabilities. Product defaults and session-level choices remain available.

## Managed destinations

- `settings.json` → `~/.claude/settings.json`
- `CLAUDE.md` → `~/.claude/CLAUDE.md`
- Each agent → `~/.claude/agents/<name>.md`
- Each hook script → `~/.claude/hooks/<name>`
- Each repository-owned skill → `~/.claude/skills/<name>/`
- Each compatible installed Azure skill → `~/.claude/skills/<name>/`

The installer backs up conflicting managed paths and does not replace `~/.claude.json`, credentials, plugins, sessions, logs, or other runtime state.

The Ruff hook uses `python3` to parse native hook payloads and silently skips formatting when Python or Ruff is unavailable.

Once linked, Claude Code discovers these files natively on every launch. Editing the repository files takes effect through the symlinks without rerunning an installer.

## MCP behavior

No MCP server is forced globally. The previously considered memory server requires a separately installed runtime, and GitHub requires host-specific OAuth or a token. Enabling either by default would add startup failures or authentication prompts, so Claude keeps its normal built-in capabilities and existing project/user MCP configuration remains available.

## Azure skills

The installer links only the 17 existing Azure skills whose instruction contracts are Claude-compatible. It does not install dependencies, authenticate services, or copy telemetry hooks. Skills requiring Copilot-specific confirmation wrappers, VS Code commands, or fixed tool names are intentionally excluded.

## Exclusions

The mirror excludes organization-specific logistics content, Streamlit agents and guidance, corporate MCP servers, Azure telemetry, tokens, authentication databases, generated state, and consumer Claude personalization.
