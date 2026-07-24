---
description: "Use before calling task_complete. Enforces a pre-completion pipeline: pull latest, lint, format, test, pre-commit hooks, auto-commit, and failure notification."
---

# Pre-Completion Pipeline

**IMPORTANT**: If the workspace `copilot-instructions.md` (or
`.github/copilot-instructions.md`) defines its own pre-completion pipeline,
follow **only** that pipeline. **Do not** run the generic steps below -
the workspace-specific pipeline takes full precedence and already contains
all necessary steps. Running both causes duplicate subagent spawns.

**DEFERRED EXECUTION**: If the workspace supports deferred pipeline
execution (e.g., via a `/finalize` prompt), defer to that pattern and
only run the pipeline when the user explicitly triggers it.

---

## Generic Fallback (only when no workspace pipeline exists)

**Before calling `task_complete`**, run the following pipeline sequentially
using `run_in_terminal` or `execution_subagent` directly. **Never**
delegate the pipeline to `runSubagent` - subagents lack terminal tools
and will fail. If any step fails, fix the issue and restart from step 1.

1. **Pull latest** - `git pull origin main` (resolve merge conflicts before
   continuing; if no git remote or on a detached HEAD, skip this step)
2. **Lint** - run the project linter with auto-fix:
   - If `pyproject.toml` exists and contains `[tool.ruff]`:
     `uv run ruff check --fix <source_dirs>`
   - Adapt the command to the project's package manager (`uv`, `npm`, etc.)
3. **Format** - run the project formatter:
   - Ruff: `uv run ruff format <source_dirs>`
   - Adapt to the project's formatter (Prettier, Black, etc.)
4. **Unit tests** - run the project's unit test suite; all tests must pass
5. **Smoke / integration tests** - if the project defines a smoke marker or
   integration test suite, run it (e.g., `uv run pytest -m smoke -v`)
6. **Pre-commit hooks** - if `.pre-commit-config.yaml` exists:
   `pre-commit run --all-files` (all hooks must pass)
7. **Auto-commit**: If any files were modified during the session,
   stage and commit them with a **Conventional Commits** message:
   - Format: `<type>(<scope>): <summary>` (e.g.,
     `feat(ui): add KPI cards to drift detection page`)
   - Types: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `ci`
   - Scope: the area of the codebase changed
   - Summary: imperative mood, lowercase, no period, max ~72 chars
   - Body (optional): blank line after summary, then bullet points
     describing **what** changed and **why**
   - **Never** use a bare commit hash, branch name, or generic
     message like "update files" or "fix stuff" as the message

## Rules

- Run all steps **sequentially in one terminal** using `run_in_terminal`
  or `execution_subagent`. **Never** use `runSubagent` for pipeline steps
  (subagents do not have terminal tools).
- **Do not call `task_complete`** until every step passes in sequence
  without failures.
- When a step is not applicable (e.g., no pre-commit config, no smoke tests),
  skip it and continue to the next step.
- **Notify on failure**: If any pipeline step fails and cannot be fixed after
  3 retry attempts, run the following before stopping:
  ```bash
  osascript -e 'display notification "Pre-completion pipeline failed - manual intervention needed" with title "⚠️ Copilot Pipeline"'
  ```
