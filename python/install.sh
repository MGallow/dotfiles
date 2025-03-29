#!/bin/bash

echo "Setting up Python development environment..."

# Install Miniconda if not already installed
if ! command -v conda &> /dev/null; then
    if [ "$(uname -s)" == "Darwin" ]; then
        echo "Installing Miniconda via Homebrew..."
        brew install --cask miniconda
    fi
fi

# Initialize conda for shell if not already done
if [ -f "/opt/homebrew/Caskroom/miniconda/base/bin/conda" ]; then
    eval "$(/opt/homebrew/Caskroom/miniconda/base/bin/conda shell.zsh hook)"
    conda init zsh
fi

# Create or update base conda environment.yml
cat > "$DOTFILES/python/environment.yml" << EOF
name: base
channels:
  - conda-forge
  - defaults
dependencies:
  - python>=3.9
  - pip
  - ipython
  - jupyter
  - jupyterlab
  - black
  - flake8
  - mypy
  - pytest
  - pytest-cov
  - numpy
  - pandas
  - matplotlib
  - seaborn
  - scikit-learn
  - pip:
    - pre-commit
    - python-dotenv
EOF

# Update base environment with our dependencies
echo "Updating conda environment..."
conda env update -f "$DOTFILES/python/environment.yml"

# Setup pre-commit hooks for Python projects
if [ ! -f "$DOTFILES/python/pre-commit-config.yaml" ]; then
    cat > "$DOTFILES/python/pre-commit-config.yaml" << EOF
repos:
-   repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
    -   id: trailing-whitespace
    -   id: end-of-file-fixer
    -   id: check-yaml
    -   id: check-added-large-files
-   repo: https://github.com/psf/black
    rev: 23.3.0
    hooks:
    -   id: black
-   repo: https://github.com/pycqa/flake8
    rev: 6.0.0
    hooks:
    -   id: flake8
EOF
fi

# Create default Python configurations
if [ ! -f "$DOTFILES/python/pyproject.toml" ]; then
    cat > "$DOTFILES/python/pyproject.toml" << EOF
[tool.black]
line-length = 88
target-version = ['py39']
include = '\.pyi?$'

[tool.pytest.ini_options]
addopts = "-ra -q --cov"
testpaths = ["tests"]
python_files = ["test_*.py", "*_test.py"]

[tool.mypy]
python_version = "3.9"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true
EOF
fi

echo "Python development environment setup complete!"
