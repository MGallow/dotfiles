---
description: "Use when writing or editing Python code. Enforces modern Python 3.11+ patterns, type hints, and coding standards."
applyTo: "**/*.py"
---

# Python Coding Standards

## Type System

- Use native generics: `list[]`, `dict[]`, `tuple[]`, `T | None` — never
  import `List`, `Dict`, `Tuple`, `Optional`, `Union` from `typing`
- Only import from `typing` what still lives there: `Any`, `TYPE_CHECKING`,
  `Protocol`, `Final`, `cast`
- Add type hints to all function arguments and return values
- All functions should have explicit return types (including `-> None`)

## Docstrings (Google-style, Ruff D-rules)

- Summary line on the same line as opening `"""`
- One blank line between summary and description (if description exists)
- Blank line before each section (`Args:`, `Returns:`, `Raises:`, `Note:`)
- Blank line after each section
- No blank line between closing `"""` and the first line of code
- Use `Attributes:` section for Pydantic model fields and dataclass fields

## Code Patterns

- Use `match`/`case` statements instead of `if-elif-else` chains
- Use f-strings for string formatting; exception: SQL templates loaded from
  `.sql` files via `load_sql()` use `.format()` for placeholder substitution
- Use `pathlib.Path` instead of `os.path` for file/directory manipulation
  (`os.getenv()` for environment variables is fine)
- Use `-` for dashes, not en-dash `‑`
- Keep line length to a maximum of 125 characters

## Logging

- Use `structlog` — never `print()` or `import logging`
- Initialize as `logger = structlog.get_logger(__name__)` (always pass `__name__`)

## Data & Models

- Pydantic v2: use `model_validate`, `model_dump`, `ConfigDict(...)`,
  `field_validator`, `model_validator(mode="after")` — never v1 patterns
  like `class Config:` or `.dict()`
- Enums: use `(str, Enum)` dual-inheritance pattern for string enums
- Prefer Polars (`import polars as pl`) for data transforms; use descriptive
  DataFrame names (not `df`)
- When Pandas is required (Streamlit charting), use meaningful names

## Architecture

- Prefer `async def` over synchronous functions
- Use `httpx` instead of `requests`; always set
  `httpx.Timeout(total, connect=connect)`
- Use `tenacity` for retries: either `@tenacity.retry(...)` decorators or
  reusable policy objects with `tenacity.retry(...)` assigned to a variable
- Keep `try/except` blocks narrow and minimal — no broad `except Exception:`
- Do not add inline comments unless necessary; remove unhelpful existing ones
- Refactor for modularity without changing underlying logic
