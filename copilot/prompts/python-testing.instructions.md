---
description: "Use when writing or editing test files. Enforces pytest patterns and async test conventions."
applyTo: "**/test_*.py"
---

# Testing Standards

## Organization

- Group tests in `class Test*` classes — nearly all tests use class-based
  grouping
- One test file per source module (e.g., `test_client.py` tests
  `engine/client.py`)
- Dashboard tests are split by type: `test_dashboard_smoke.py`,
  `test_dashboard_integration.py`, `test_dashboard_pages.py`,
  `test_dashboard_apptest.py`

## Naming & Types

- Name tests as `test_<what_is_being_tested>_<expected_outcome>`
  (e.g., `test_valid_modes_pass`, `test_retryable_codes_return_true`)
- All test functions must have `-> None` return type annotation
- All fixture functions must have return type annotations

## Fixtures

- Use `@pytest.fixture` for shared setup — prefer conftest.py over local
  duplication
- Construct test data as inline Pydantic models or Polars DataFrames, not
  fixture files or factory libraries
- Use `autouse=True` for state-reset fixtures (e.g., clearing globals)
- Use `scope="module"` for expensive shared resources (e.g., HTTP clients)
- Use `Generator` yield fixtures for context-managed resources

## Async Testing

- Mark every async test with `@pytest.mark.asyncio` (explicit, no auto mode)
- Use `AsyncMock` from `unittest.mock` for async mocking
- Do NOT use `@pytest_asyncio.fixture` — use regular fixtures with
  `AsyncMock` instead

## Mocking

- Use `unittest.mock` exclusively: `MagicMock`, `AsyncMock`, `patch`,
  `patch.object` — never `pytest-mock` or `monkeypatch`
- Always use `spec=` on `MagicMock` when mocking real objects
  (e.g., `MagicMock(spec=httpx.Response, status_code=200)`)
- Use `patch` as context manager or decorator to mock module-level
  functions and classes

## Assertions

- Use plain `assert` as the primary assertion pattern
- Use `pytest.raises(ExceptionType, match="regex")` with `match=` for
  exception testing
- Use `pytest.approx` for floating-point comparisons
- Use identity checks: `assert result is True`, `assert result is None`

## Parametrize

- Use `@pytest.mark.parametrize` for input variations and boundary testing
- Use tuple parametrize with `ids=` for readable test output:
  `@pytest.mark.parametrize(("input", "expected"), [...], ids=[...])`

## Markers

- `@pytest.mark.smoke` for dashboard smoke tests (excluded by default via
  `addopts = "-m 'not smoke'"`; run with `uv run pytest -m smoke -v`)
