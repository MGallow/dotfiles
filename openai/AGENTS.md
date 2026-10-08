# General Coding Instructions

## Working Approach
- Read the repository instructions and relevant code before making changes.
- Follow project-specific conventions; use these preferences where the project
  does not specify otherwise.
- Make focused, minimal changes. Preserve existing behavior unless a behavior
  change is explicitly requested.
- Prefer reusable, modular code without unnecessary abstractions.
- Act on clear requests. Ask questions only when ambiguity materially affects
  correctness, scope, architecture, or safety.
- Ground conclusions in inspected code, diagnostics, runtime evidence, or tests.
  Clearly distinguish verified facts from assumptions.
- Never claim that tests, queries, or commands succeeded unless they actually ran.
- Preserve unrelated user changes. Do not perform destructive Git operations,
  start or restart services, or commit changes without explicit authorization.
- Keep responses concise. Summarize changes, validation, and remaining limitations.

## Preferred Stack
- Python 3.11+, managed with uv.
- FastAPI, Streamlit, FastMCP, Pydantic v2, and Polars.
- pytest and pytest-asyncio for testing.
- Ruff for linting and formatting; follow configured type-checking tools.
- structlog for logging.
- httpx for HTTP, asyncpg for PostgreSQL, and tenacity for retries.
- Apply these preferences to relevant Python projects, not unrelated stacks.

## Python Style
- Use native generics: list[T], dict[K, V], tuple[T, ...], and T | None.
- Add type hints to every function argument and return value, including -> None.
- Prefer match statements for suitable multi-branch dispatch.
- Use Google-style docstrings for modules, classes, and functions.
- Separate docstring summaries, descriptions, and sections with blank lines.
  Do not leave a blank line between a docstring and its function body.
- Use descriptive names, especially for DataFrames; avoid generic names like df.
- Use f-strings for ordinary string formatting, never for SQL.
- Use pathlib.Path instead of os.path.
- Default to a maximum line length of 125 characters unless configured otherwise.
- Use ordinary hyphens rather than typographic dashes in Python source.
- Add comments only when they explain non-obvious intent or constraints.
- Use enums for repeated domain constants and categorical string values.
- Avoid broad exception handling and unnecessary try/except blocks.
- Preserve business logic during refactoring.

## Architecture and External I/O
- Prefer async functions for asynchronous I/O. Do not block the event loop.
- Use httpx rather than requests, with explicit overall and connection timeouts.
- Use structlog instead of print statements or UI output for debugging.
- Use bounded tenacity retries for appropriate transient external failures.
- Use Pydantic v2 for validation and schema parsing.
- Prefer Polars for new data transformations. Use Pandas when an integration
  requires it.
- Reuse existing connection management. Respect database connection thread safety.
- Use asyncpg for asynchronous PostgreSQL access.
- For Snowflake projects using chr-sql, retain the established connector pattern
  and use polars.read_database where appropriate.
- Respect configured package sources. Do not assume access to internal services,
  registries, credentials, or databases.

## SQL and Analytics
- Keep SQL in separate .sql templates rather than embedding it in Python.
- Bind all values using the database driver's parameter syntax.
- Use .format() only for controlled structural SQL placeholders.
- Validate structural substitutions using allowlists, enums, or other explicit
  constraints. Never interpolate user-provided values into SQL text.
- Never use f-strings or quoted string substitution to construct SQL values.
- Follow the repository's SQL style. Otherwise prefer lowercase keywords,
  four-space indentation, and one selected column or predicate per line.
- SQL is the source of truth for analytics row selection, vintage deduplication,
  and series definitions. Do not silently reselect or deduplicate series in UI code.
- Validate changed queries on their intended engine with representative parameters
  when authorized and safe. Bound execution and avoid fetching unnecessary rows.
- Linting, EXPLAIN, and constructing a lazy plan do not establish successful execution.
- If execution is unavailable or unsafe, explicitly report what remains unverified.
- Respect human-owned or protected query logic; modify it only with explicit approval.

## FastAPI
- Organize endpoints in router modules using APIRouter with prefixes and tags.
- Use typed Pydantic request and response models.
- Prefer async route handlers and keep business logic outside handlers.

## Streamlit
- Follow the project's page structure and dashboard style guide.
- Reuse shared colors, typography, chart helpers, and sidebar components.
- Use width="stretch" or width="content", not use_container_width.
- Keep heavy data loading and refresh logic outside page rendering.
- Reuse existing background-refresh and caching infrastructure.
- Prefer Parquet for persistent analytical assets; partition when appropriate.
- Use structlog for diagnostics, not st.write.
- Do not launch, stop, or restart Streamlit unless explicitly requested.
  Rely on hot reload for code changes.
- Confirm the actual application entry point before any authorized launch;
  do not run a launcher wrapper as the Streamlit application.

## MCP
- Prefer FastMCP for Python MCP servers.
- Follow existing tool organization and registration patterns.
- Provide accurate tool annotations, including read-only and destructive behavior.
- Keep tool inputs, outputs, and descriptions explicit and typed.

## Dependencies and Testing
- Use uv for Python environments, dependency changes, and command execution.
- Use uv add/remove rather than manually editing dependency declarations.
- Follow configured registries; do not silently substitute package sources.
- Use pytest, with class-based grouping where appropriate.
- Use unittest.mock rather than pytest-mock.
- Use pytest-asyncio and appropriate async fixtures for asynchronous tests.
- Add regression tests for bug fixes and cover meaningful edge cases.
- Run relevant tests and lint/type checks after changes.
- Report exactly what was run, what passed or failed, and what was not checked.

## Finalization
- Ordinary requests do not authorize a full release or commit pipeline.
- Treat an explicit /finalize request as authorization to run the repository's
  documented finalization workflow.
- Adapt commands to the actual repository; do not assume a branch name, directory
  layout, lifecycle hook, or operating system.
- Run blocking validation steps sequentially and resolve failures before proceeding.
- Bound smoke tests. Report failures or timeouts; whether they block completion
  should follow repository policy.
- Never run smoke tests that launch services without explicit authorization.
- Commit only within the authorized scope, using Conventional Commits:
  <type>(<scope>): <imperative summary>
- Do not stage unrelated user changes unless explicitly asked to include them.
- Verify and report the final Git status; do not claim a clean tree without checking.
