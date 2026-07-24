# OpenAI Codex Configuration

This topic mirrors portable user-level Copilot behavior through documented Codex CLI and editor configuration surfaces. It does not configure consumer ChatGPT web custom instructions, GPTs, Projects, or Memory.

The managed config is additive: it does not pin a model or reasoning level, change approval or sandbox policy, disable login shells or networking, cap agents, remove temporary-directory access, or otherwise replace Codex product defaults.

## Managed destinations

- `config.toml` → `~/.codex/config.toml`
- `AGENTS.md` → `~/.codex/AGENTS.md`
- Each agent → `~/.codex/agents/<name>.toml`
- Each workflow skill → `~/.codex/skills/<name>/`

Codex continues to scan its backward-compatible `$CODEX_HOME/skills` user scope and follows symlinked skill directories there. The five mirrored workflows are linked into `~/.codex/skills`, which Codex discovers automatically but Copilot does not scan. They are deliberately not linked into shared `~/.agents/skills`, guaranteeing that Copilot's available skills remain unchanged. The installer does not replace credentials, databases, logs, memories, shell snapshots, temporary files, or other Codex runtime state.

Python formatting behavior is expressed in the always-loaded `AGENTS.md` rather than a command hook. Codex requires manual trust approval for every non-managed hook definition and for each changed hook hash; omitting the hook avoids that activation gate while retaining best-effort Ruff behavior.

Once linked, Codex discovers these files natively on every launch. Editing the repository files takes effect through the symlinks without rerunning an installer.

## MCP behavior

No MCP server is forced globally. The previously considered memory server requires a separately installed runtime, and GitHub requires host-specific OAuth or a token. Enabling either by default would add startup failures or authentication prompts, so Codex keeps its normal built-in capabilities and project-level MCP configuration remains available when already configured.

## Exclusions

The mirror excludes organization-specific logistics content, Streamlit agents and guidance, corporate MCP servers, Azure telemetry, tokens, authentication databases, generated state, and consumer ChatGPT personalization. Machine-specific project trust entries are also excluded, including trust for the filesystem root.
