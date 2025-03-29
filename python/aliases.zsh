# Python aliases and conda environment management
alias py='python'
alias ipy='ipython'
alias jl='jupyter lab'
alias jn='jupyter notebook'
alias pt='pytest'
alias ptv='pytest -v'
alias ptx='pytest -x'  # Stop on first failure
alias ptc='pytest --cov'  # Run with coverage

# Conda environment management (primary)
alias ca='conda activate'
alias cda='conda deactivate'
alias cl='conda list'
alias ce='conda env list'
alias ci='conda install'
alias cud='conda update'
alias cen='conda env create -f'
alias cer='conda env remove -n'

# Virtual environment (legacy support)
alias va='conda activate'
alias vd='conda deactivate'

# Django shortcuts (if you use Django)
alias pm='python manage.py'
alias pmr='python manage.py runserver'
alias pmm='python manage.py migrate'
alias pmmm='python manage.py makemigrations'
alias pmsh='python manage.py shell'

# Package management
alias pipi='conda install'  # Prefer conda install
alias pipf='pip freeze > requirements.txt'
alias pipr='pip install -r requirements.txt'

# Development tools
alias black='black .'
alias flake='flake8'
alias mypy='mypy .'

# Functions
pycreate() {
    if [ -z "$1" ]; then
        echo "Usage: pycreate <project_name>"
        return 1
    fi

    mkdir -p "$1"/{src,tests,docs}
    touch "$1/README.md"
    touch "$1/environment.yml"  # Use conda environment.yml instead of requirements.txt
    cp "$DOTFILES/python/pyproject.toml" "$1/pyproject.toml"
    cp "$DOTFILES/python/pre-commit-config.yaml" "$1/.pre-commit-config.yaml"

    # Create default conda environment.yml
    cat > "$1/environment.yml" << EOF
name: ${1//[^a-zA-Z0-9]/-}
channels:
  - conda-forge
  - defaults
dependencies:
  - python>=3.9
  - pip
  - ipython
  - pytest
  - black
  - flake8
  - mypy
EOF

    echo "Created Python project structure in $1"
}

pyenv() {
    if [ -z "$1" ]; then
        echo "Usage: pyenv <environment_name>"
        return 1
    fi

    conda create -n "$1" python=3.9 ipython jupyter black flake8 pytest mypy -y
    conda activate "$1"
    echo "Created and activated conda environment: $1"
}

pyclean() {
    find . -type f -name "*.py[co]" -delete
    find . -type d -name "__pycache__" -delete
    find . -type d -name ".pytest_cache" -delete
    find . -type d -name ".coverage" -delete
    find . -type f -name ".coverage" -delete
    echo "Cleaned Python cache files"
}
