---
description: "Review code for quality, type safety, and style issues"
agent: "agent"
argument-hint: "Specify file(s) or describe what to review"
---

Review the specified code and report issues in these categories:

1. **Type Safety**: Missing type hints, incorrect types, `Any` usage
2. **Style**: Violations of Google docstring format, line length, naming conventions
3. **Patterns**: Use of deprecated patterns (e.g., `os.path` instead of `pathlib`, `requests` instead of `httpx`)
4. **Error Handling**: Over-broad exception catching, missing error handling
5. **Async**: Synchronous functions that should be async
6. **Testing**: Missing test coverage for new/changed code

For each issue, show the file, line, and a concrete fix. Group by severity (error, warning, suggestion).
