# Python / conda / uv / ruff aliases

# ── Python shortcuts ──────────────────────────────────────────────────────────
alias py='python'
alias ipy='ipython'
alias jl='jupyter lab'
alias jn='jupyter notebook'

# ── Conda environment management ─────────────────────────────────────────────
alias ca='conda activate'
alias cda='conda deactivate'
alias clist='conda list'           # NOTE: 'cl' is reserved for Claude Code
alias ce='conda env list'
alias ci='conda install'
alias cud='conda update'
alias cen='conda env create -f'    # cen environment.yml
alias cer='conda env remove -n'    # cer myenv

# ── uv — fast package installer inside conda envs ────────────────────────────
alias uvi='uv pip install'         # uvi pandas numpy
alias uvs='uv pip sync'            # sync from requirements file
alias uvf='uv pip freeze'          # print installed packages
alias uvr='uv pip install -r'      # uvr requirements.txt

# ── ruff — linter + formatter (replaces black, flake8, isort) ─────────────────
alias rf='ruff check .'            # lint the current directory
alias rff='ruff check . --fix'     # lint and auto-fix
alias rfmt='ruff format .'         # format (black-compatible)
alias rfmt1='ruff format'          # format a single file: rfmt1 foo.py

# ── pytest ────────────────────────────────────────────────────────────────────
alias pt='pytest'
alias ptv='pytest -v'
alias ptx='pytest -x'             # stop on first failure
alias ptc='pytest --cov'          # run with coverage
alias ptvv='pytest -vv --tb=short' # verbose with short tracebacks

# ── mypy ──────────────────────────────────────────────────────────────────────
alias mpy='mypy .'

# ── pre-commit ────────────────────────────────────────────────────────────────
alias pc='pre-commit run --all-files'
alias pci='pre-commit install'
alias pcu='pre-commit autoupdate'

# ── Functions ─────────────────────────────────────────────────────────────────

# pycreate <project_name>
# Scaffold a new Python project with conda + uv + ruff + pre-commit
pycreate() {
    if [ -z "$1" ]; then
        echo "Usage: pycreate <project_name>"
        return 1
    fi

    local name="$1"
    local env_name="${name//[^a-zA-Z0-9]/-}"

    mkdir -p "$name"/{src,tests,docs}
    touch "$name/README.md"
    touch "$name/tests/__init__.py"

    # pyproject.toml from template
    sed "s/PROJECT_NAME/$name/" "$DOTFILES/python/pyproject.toml.template" \
        > "$name/pyproject.toml"

    # pre-commit config
    cp "$DOTFILES/.pre-commit-config.yaml" "$name/.pre-commit-config.yaml"

    # conda environment.yml for this project
    cat > "$name/environment.yml" <<EOF
name: ${env_name}
channels:
  - conda-forge
  - defaults
dependencies:
  - python>=3.11
  - pip
  - uv
EOF

    # .gitignore
    cat > "$name/.gitignore" <<'EOF'
__pycache__/
*.py[cod]
.pytest_cache/
.mypy_cache/
.ruff_cache/
.coverage
htmlcov/
dist/
*.egg-info/
.env
.venv
EOF

    echo "Created Python project: $name"
    echo ""
    echo "  Next steps:"
    echo "    cd $name"
    echo "    conda env create -f environment.yml"
    echo "    conda activate $env_name"
    echo "    uv pip install -e '.[dev]'"
    echo "    pre-commit install"
}

# pyenv <env_name> [python_version]
# Create and activate a new named conda environment with uv + ruff pre-installed
pyenv() {
    if [ -z "$1" ]; then
        echo "Usage: pyenv <env_name> [python_version]"
        return 1
    fi

    local pyver="${2:-3.11}"
    conda create -n "$1" "python=$pyver" uv ruff mypy pytest pre-commit -y
    conda activate "$1"
    echo "Created and activated conda environment: $1 (Python $pyver)"
    echo "Use 'uv pip install <package>' to add packages."
}

# pyclean
# Remove Python bytecode and tool cache directories
pyclean() {
    find . -type f -name "*.py[co]" -delete
    find . -type d -name "__pycache__" -delete
    find . -type d -name ".pytest_cache" -delete
    find . -type d -name ".mypy_cache" -delete
    find . -type d -name ".ruff_cache" -delete
    find . -type f -name ".coverage" -delete
    echo "Cleaned Python cache files"
}
