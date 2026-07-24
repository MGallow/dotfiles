---
name: commit
description: Create a focused Conventional Commit from the intended working-tree changes when explicitly requested.
---

# Commit Changes

Use this skill only when the user explicitly asks to create a commit.

1. Inspect Git status, staged and unstaged changes, and the diff summary.
2. Preserve an existing staged selection. If nothing is staged, stage only the intended changes; do not include unrelated or sensitive files.
3. Select an appropriate Conventional Commit type: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, or `style`.
4. Write an imperative subject under 72 characters. Add a body when rationale or multi-file impact needs explanation.
5. Create the commit and show its summary. If there is nothing to commit, report that instead.

Never push unless the user explicitly asks.
