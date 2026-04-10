---
description: "Generate a git commit with a conventional commit message based on staged or unstaged changes"
agent: "agent"
tools: [execute, read, search]
argument-hint: "Optional: describe the intent of the changes, or leave blank to auto-detect"
---

Create a well-crafted git commit for the current changes:

1. Run `git diff --stat` and `git diff` to understand what changed
2. If nothing is staged, run `git add -A` first
3. Analyze the changes and determine the conventional commit type:
   - `feat:` — new feature
   - `fix:` — bug fix
   - `refactor:` — code improvement without behavior change
   - `test:` — adding or updating tests
   - `docs:` — documentation changes
   - `chore:` — maintenance, dependencies, config
   - `style:` — formatting, linting
4. Write a concise commit message: `type: short description`
5. Add a body if changes span multiple files or need explanation
6. Run `git commit -m "..."` with the message
7. Show the commit with `git log -1 --stat`

Keep the subject line under 72 characters. Use imperative mood.
