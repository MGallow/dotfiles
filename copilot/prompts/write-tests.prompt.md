---
description: "Write comprehensive tests for specified code. Analyzes the module, identifies test cases, and generates a complete test file."
agent: "agent"
argument-hint: "Specify the module/function to test (e.g., 'tce_inspector_api/services/inspection.py')"
---

Write comprehensive tests for the specified code:

1. Read the target module and understand its public interface
2. Read existing test files in the project first to match their patterns
3. Find the conftest.py for shared fixtures
4. Generate tests covering:
   - Happy path for each public function/method
   - Edge cases and boundary values
   - Error conditions and exception paths
   - Parametrized variations where inputs vary
5. Follow the project's testing conventions exactly (class-based grouping,
   naming, mocking patterns)
6. Run the tests to verify they pass
