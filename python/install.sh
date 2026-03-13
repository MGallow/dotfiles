#!/usr/bin/env bash
#
# Set up the Python development environment.
# Stack: Miniconda (environment management) + uv (fast package installation) + ruff (linting/formatting)

set -e

echo "› Setting up Python development environment..."

# ── Miniconda ─────────────────────────────────────────────────────────────────
if ! command -v conda &>/dev/null; then
    if [ "$(uname -s)" = "Darwin" ]; then
        echo "  Installing Miniconda via Homebrew..."
        brew install --cask miniconda
    fi
fi

# Initialize conda for zsh (only if not already initialized)
CONDA_BIN="/opt/homebrew/Caskroom/miniconda/base/bin/conda"
if [ -f "$CONDA_BIN" ] && ! grep -q "conda initialize" "$HOME/.zshrc" 2>/dev/null; then
    eval "$($CONDA_BIN shell.zsh hook)"
    conda init zsh
fi

# ── uv ────────────────────────────────────────────────────────────────────────
# uv is the fast Python package installer used inside conda environments.
# Prefer brew (already listed in Brewfile); fall back to the official installer.
if ! command -v uv &>/dev/null; then
    echo "  Installing uv..."
    if command -v brew &>/dev/null; then
        brew install uv
    else
        curl -LsSf https://astral.sh/uv/install.sh | sh
    fi
fi
echo "  uv: $(uv --version 2>/dev/null || echo 'installed')"

# ── Base conda environment ────────────────────────────────────────────────────
# Written to $HOME (outside the repo) so it is never accidentally committed.
BASE_ENV_YML="$HOME/.conda-base-environment.yml"
cat > "$BASE_ENV_YML" <<'ENVEOF'
name: base
channels:
  - conda-forge
  - defaults
dependencies:
  - python>=3.11
  - pip
  - uv
  - ipython
  - jupyterlab
  - ruff
  - mypy
  - pytest
  - pytest-cov
  - pre-commit
  - python-dotenv
ENVEOF

echo "  Updating base conda environment (this may take a moment)..."
conda env update -f "$BASE_ENV_YML" --prune 2>/dev/null || true

# ── Project pyproject.toml template ──────────────────────────────────────────
# pycreate() and pyenv() copy this into new projects.
PYPROJECT_TEMPLATE="$DOTFILES/python/pyproject.toml.template"
cat > "$PYPROJECT_TEMPLATE" <<'TOMLEOF'
[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[project]
name = "PROJECT_NAME"
version = "0.1.0"
requires-python = ">=3.11"
dependencies = []

[tool.ruff]
line-length = 88
target-version = "py311"

[tool.ruff.lint]
# E/F = pycodestyle/pyflakes, I = isort, N = pep8-naming,
# UP = pyupgrade, B = flake8-bugbear, C4 = comprehensions, PT = pytest-style
select = ["E", "F", "I", "N", "W", "UP", "B", "C4", "PT"]
ignore = []

[tool.ruff.format]
quote-style = "double"
indent-style = "space"

[tool.mypy]
python_version = "3.11"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true

[tool.pytest.ini_options]
addopts = "-ra -q"
testpaths = ["tests"]
python_files = ["test_*.py", "*_test.py"]
TOMLEOF

echo "  Python development environment setup complete."
echo "  Use 'pycreate <name>' to scaffold a new project with uv + ruff."
