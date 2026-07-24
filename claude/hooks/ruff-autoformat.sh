#!/usr/bin/env bash
# User-level PostToolUse hook: auto-format Python files after Claude edits.
set -euo pipefail

INPUT=$(cat)

FILES=$(printf '%s' "$INPUT" | python3 -c '
import json
import sys

data = json.load(sys.stdin)
paths = []

def collect_paths(value):
    if isinstance(value, dict):
        for key, child in value.items():
            if key in {"file_path", "filePath", "path"} and isinstance(child, str):
                paths.append(child)
            else:
                collect_paths(child)
    elif isinstance(value, list):
        for child in value:
            collect_paths(child)

collect_paths(data.get("tool_input", {}))
for path in dict.fromkeys(paths):
    if path.endswith(".py"):
        print(path)
' 2>/dev/null || true)

while IFS= read -r FILE; do
    [[ -n "$FILE" ]] || continue
    if [[ -f "$FILE" ]]; then
        if command -v uv &>/dev/null && [[ -f pyproject.toml ]]; then
            uv run ruff check --fix --quiet "$FILE" 2>/dev/null || true
            uv run ruff format --quiet "$FILE" 2>/dev/null || true
        elif command -v ruff &>/dev/null; then
            ruff check --fix --quiet "$FILE" 2>/dev/null || true
            ruff format --quiet "$FILE" 2>/dev/null || true
        fi
    fi
done <<< "$FILES"
