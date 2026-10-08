# OpenAI Codex Configuration

This topic mirrors portable user-level Copilot behavior through documented Codex CLI and editor configuration surfaces. It does not configure consumer ChatGPT web custom instructions, GPTs, Projects, or Memory.

The user's `config.toml` is private and ignored by Git. It may contain model preferences, desktop settings, MCP registrations, corporate service and package registry URLs, project trust, and machine-specific paths. The installer preserves it and creates it from the sanitized `config.toml.example` only when missing.

## Managed destinations

- `config.toml` → `~/.codex/config.toml`
- `AGENTS.md` → `~/.codex/AGENTS.md`
- Each agent → `~/.codex/agents/<name>.toml`
- Each workflow skill → `~/.codex/skills/<name>/`

Codex continues to scan its backward-compatible `$CODEX_HOME/skills` user scope and follows symlinked skill directories there. The installer links every directory in `openai/skills` into `~/.codex/skills`; it does not add links in shared `~/.agents/skills`. The installer does not replace credentials, databases, logs, memories, shell snapshots, temporary files, or other Codex runtime state.

Alongside the five tracked general workflows, optional private skills may be kept locally:

- `python-package-sources`: corporate Python sources and isolated uv launchers, scoped to CH Robinson work and package-source diagnostics.
- `mlflow-mcp`: Codex-specific operation and troubleshooting guidance for the existing MLflow registration.
- `tce-logistics`: a read-only specialist for canonical TCE business definitions and implementation evidence.
- `tce-streamlit`: TCE dashboard conventions, complementing the project's existing general Streamlit skill.

These four company-specific skill directories are ignored by Git. The installer links them when present; they are not included in a fresh clone. Project specialists resolve documentation from the active checkout rather than copying business definitions into tracked dotfiles. No additional agent roles or model overrides are required.

Python linting and formatting are requested through `AGENTS.md` and relevant skills. This is guidance, not automatic formatting after each edit. No Ruff command hook is installed.

Once linked, Codex discovers these files natively on every launch. Editing the repository files takes effect through the symlinks without rerunning an installer.

## MCP behavior

MCP registrations belong in the ignored local `config.toml`. The tracked example contains no server registrations or registry URLs. Private skills do not add servers, change authentication, or establish connectivity. Available tools depend on the active Codex session and server state; configuration presence alone does not prove successful initialization or queries.

## Exclusions

Tracked content excludes company-specific skills, private MCP configuration, registry URLs, tokens, authentication databases, and generated state. Existing private files and their symlinks are preserved locally. Git ignore rules do not remove values from older commits; history cleanup requires a separate coordinated change.
