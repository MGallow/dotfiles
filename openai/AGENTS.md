# Personal Coding Guidance

Follow repository-local instructions when they are more specific. Do not add a dependency or change a project's supported language version solely to satisfy these preferences.

## Python

- Use native generics and `T | None` when the supported Python version allows them.
- Type every function argument and return value, including `-> None`.
- Use consistent Google-style docstrings for public modules, classes, and functions.
- Prefer `pathlib.Path` to `os.path`.
- Use f-strings for ordinary string formatting while preserving a repository's SQL templating mechanism.
- Respect the repository's configured line length; use 125 only when no project limit exists.
- Keep exception scopes narrow and avoid broad catches without a specific recovery strategy.
- Use `match` only when it is clearer than the equivalent conditional logic.
- Prefer async functions only for genuinely asynchronous interfaces or I/O paths.
- Avoid unnecessary comments, unrelated cleanup, and behavior changes hidden inside refactors.

When already used by the project, follow its established patterns for Pydantic v2, structured logging, Polars, HTTP clients with explicit timeouts, and bounded retry policies. Do not introduce those dependencies merely to conform to these preferences.

## SQL

- Preserve the repository's SQL-template conventions.
- Use bind parameters for values, especially user-supplied values.
- Never interpolate values with f-strings or structural formatting.
- Restrict structural substitution to validated identifiers or fragments.

## Python Tests

- Use pytest and follow the repository's existing test organization.
- Cover normal behavior, boundaries, meaningful input variations, and error paths.
- Prefer parameterization to duplicated tests.
- Reuse existing fixtures and mock at dependency boundaries.
- Prefer `unittest.mock` tools such as `MagicMock`, `AsyncMock`, and `patch`; add `spec=` for concrete interfaces.
- Use `pytest.raises(..., match=...)` and `pytest.approx` where appropriate.
- Type test functions and fixtures.
- Use async test markers and async fixtures when required by project configuration.
- Keep tests deterministic and run the narrowest relevant test command before broader checks.

## Safety and Scope

- Preserve unrelated working-tree changes.
- Never expose or commit credentials, tokens, environment files, or private keys.
- Do not create commits, push changes, or run a repository-wide finalization workflow unless explicitly requested.

Codex does not provide a native global glob equivalent to Copilot's `applyTo` instructions. Treat the Python sections as conditional guidance for Python work, with nested repository `AGENTS.md` files taking precedence.

## Python Edit Hygiene

After editing Python files, run the project's configured Ruff fix and format commands when Ruff is already available. Treat formatting as best-effort: do not install dependencies solely for this step, and do not let an unavailable formatter block unrelated work.
