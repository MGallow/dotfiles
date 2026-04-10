---
description: "Use before calling task_complete. Enforces a pre-completion pipeline: pull latest, lint, format, test, and run pre-commit hooks."
---

# Pre-Completion Pipeline

**Before calling `task_complete`**, run the following pipeline. If any
step fails, fix the issue and restart the pipeline from step 1. Repeat
until the full pipeline passes cleanly.

## Pipeline Steps

1. **Pull latest** — `git pull origin main` (resolve merge conflicts before
   continuing; if no git remote or on a detached HEAD, skip this step)
2. **Lint** — run the project linter with auto-fix:
   - If `pyproject.toml` exists and contains `[tool.ruff]`:
     `uv run ruff check --fix <source_dirs>`
   - Adapt the command to the project's package manager (`uv`, `npm`, etc.)
3. **Format** — run the project formatter:
   - Ruff: `uv run ruff format <source_dirs>`
   - Adapt to the project's formatter (Prettier, Black, etc.)
4. **Unit tests** — run the project's unit test suite; all tests must pass
5. **Smoke / integration tests** — if the project defines a smoke marker or
   integration test suite, run it (e.g., `uv run pytest -m smoke -v`)
6. **Pre-commit hooks** — if `.pre-commit-config.yaml` exists:
   `pre-commit run --all-files` (all hooks must pass)

## Rules

- **Do not call `task_complete`** until every step passes in sequence
  without failures.
- If a workspace `copilot-instructions.md` defines its own pre-completion
  pipeline, follow that instead — it takes precedence over this generic one.
- When a step is not applicable (e.g., no pre-commit config, no smoke tests),
  skip it and continue to the next step.
