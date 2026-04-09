#!/usr/bin/env bash
# User-level PostToolUse hook: auto-format Python files after agent edits.
# Works in any project that has ruff available (via uv, pipx, or PATH).
set -euo pipefail

INPUT=$(cat)

FILE=$(echo "$INPUT" | python3 -c "
import json, sys
data = json.load(sys.stdin)
inp = data.get('toolInput', {})
path = inp.get('filePath', inp.get('path', ''))
print(path)
" 2>/dev/null || true)

# Only act on Python files
if [[ -n "$FILE" && "$FILE" == *.py && -f "$FILE" ]]; then
    # Try project-local ruff (uv), then global ruff
    if command -v uv &>/dev/null && [[ -f "pyproject.toml" ]]; then
        uv run ruff check --fix --quiet "$FILE" 2>/dev/null || true
        uv run ruff format --quiet "$FILE" 2>/dev/null || true
    elif command -v ruff &>/dev/null; then
        ruff check --fix --quiet "$FILE" 2>/dev/null || true
        ruff format --quiet "$FILE" 2>/dev/null || true
    fi
fi
