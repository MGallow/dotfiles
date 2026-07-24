---
name: finalize
description: Run the repository's complete quality gate when explicitly requested.
disable-model-invocation: true
allowed-tools: Read, Glob, Grep, Bash, Edit, Write
---

# Final Quality Gate

Use this skill only when the user explicitly asks to finalize, validate, release, or run the complete quality gate.

1. Prefer documented repository-specific validation commands; otherwise discover applicable tooling from manifests and configuration.
2. Run applicable lint, format, unit-test, optional integration or smoke-test, and pre-commit checks sequentially.
3. Re-run affected checks if formatting or hooks modify files.
4. Use bounded retries for fixable failures and report unresolved failures.
5. Sync from upstream only when explicitly requested and after discovering the actual remote and branch.
6. Commit only when explicitly requested, following the commit workflow.
7. Report skipped checks and the reason for each skip.

Do not assume a package manager, branch name, test marker, or notification mechanism.
