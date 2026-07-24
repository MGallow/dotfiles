---
name: write-tests
description: Add focused tests for normal behavior, boundaries, variations, and error paths.
---

# Write Tests

1. Read the target module and its public interface.
2. Inspect neighboring tests and shared fixtures.
3. Cover normal behavior, edge and boundary values, error paths, and meaningful input variations.
4. Reuse fixtures and project conventions, prefer parameterization to duplication, and mock deterministically at dependency boundaries.
5. Run the new test file, then the relevant suite.
6. Report verification and intentionally uncovered paths.

For Python, use pytest unless the repository specifies otherwise. Prefer `MagicMock`, `AsyncMock`, and `patch`, adding `spec=` for concrete interfaces. Use `pytest.raises(..., match=...)` and `pytest.approx` where appropriate.
