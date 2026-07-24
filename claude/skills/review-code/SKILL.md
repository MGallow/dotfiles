---
name: review-code
description: Perform a structured code review focused on actionable defects and regressions.
allowed-tools: Read, Glob, Grep, Bash, WebFetch, WebSearch
---

# Review Code

Remain read-only. Review the requested scope for correctness, regressions, type safety, error handling, security, data exposure, concurrency, material performance, maintainability, project style, and test coverage.

For every finding, provide severity, a precise file and line range, impact, and a concrete correction. Prioritize defects over stylistic preference. Do not recommend architectural or dependency changes without evidence they fit the project.

End with an approval, request-changes, or needs-discussion verdict.
