---
description: "Refactor code for quality without changing behavior. Applies modern Python patterns, improves naming, extracts functions, and verifies with tests."
agent: "agent"
argument-hint: "Specify what to refactor (e.g., 'clean up the data processing in background_refresh.py')"
---

Refactor the specified code to improve quality WITHOUT changing behavior:

1. Read the target code and understand what it does
2. Read existing tests for the module — these are your safety net
3. Apply improvements:
   - Extract long functions into smaller, named helpers
   - Improve variable and function names for clarity
   - Apply modern Python patterns (match statements, native generics, etc.)
   - Remove dead code and unhelpful comments
   - Fix type hints and docstrings
4. Run existing tests to confirm nothing broke
5. If no tests exist, write them FIRST, then refactor

DO NOT change the external API or behavior of any public function.
