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
