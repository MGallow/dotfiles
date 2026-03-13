# Dotfiles

A collection of dotfiles and scripts to set up a complete macOS development environment from scratch. One command gets you from a bare Mac to a fully configured workstation.

**Includes out-of-the-box configuration for:**

| Tool | Purpose |
|---|---|
| Zsh + Oh My Zsh | Shell with plugins, themes, and smart aliases |
| Git | Global config, aliases, and global ignore rules |
| Vim / Tmux | Terminal editor and multiplexer |
| VS Code Insiders | Editor with 75+ extensions, ruff, Copilot |
| GitHub CLI (`gh`) | GitHub from the terminal |
| GitHub Copilot (VS Code + CLI) | AI pair programmer in editor and shell |
| Claude Code (`claude`) | Anthropic's AI coding agent |
| Gemini CLI (`gemini`) | Google's AI assistant |
| OpenAI Codex CLI (`codex`) | ChatGPT / Codex in the terminal |
| Python / Miniconda + uv | Conda environments with fast package install |
| Ruff | Fast linter + formatter (replaces black, flake8, isort) |
| pre-commit | Git hooks: ruff, mypy, secret detection |
| Google Chrome | Primary browser |
| Homebrew | macOS package manager |
| macOS defaults | Sensible system preferences |

---

## Prerequisites

Before you begin, make sure you have:

1. **macOS Monterey (12) or newer**
2. **Xcode Command Line Tools** — provides `git` and build tools:

   ```bash
   xcode-select --install
   ```

3. **A GitHub account** — needed for `gh auth login` and GitHub Copilot

---

## Quick Start (TL;DR)

```bash
# 1. Clone
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# 2. Create symlinks and prompt for Git identity
./script/bootstrap

# 3. Install everything
./script/install

# 4. Open a new terminal, then authenticate your AI tools
gh auth login
claude         # follow interactive auth
gemini         # follow interactive auth
# For Codex: add OPENAI_API_KEY to ~/.zshrc.local
```

---

## Step-by-Step Setup

### Step 1 — Clone the repository

```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

> The repo is expected to live at `~/.dotfiles`.

---

### Step 2 — Run the bootstrap script

```bash
./script/bootstrap
```

This will:
- Prompt you for your **Git author name and email** (stored in `~/.gitconfig.local`, which is gitignored)
- Create **symlinks** from your home directory to the dotfiles:
  - `~/.zshrc` → `zsh/zshrc.symlink`
  - `~/.gitconfig` → `git/gitconfig.symlink`
  - `~/.gitignore` → `git/gitignore.symlink`
  - `~/.vimrc` → `vim/vimrc.symlink`
  - `~/.tmux.conf` → `tmux/tmux.conf.symlink`
- Back up any existing conflicting files to `~/.dotfiles_backup/`

---

### Step 3 — Install everything

```bash
./script/install
```

This runs the full installation in order:

| Step | What happens |
|------|-------------|
| Homebrew | Installs Homebrew if missing, then runs `brew bundle` from `Brewfile` |
| Oh My Zsh | Installs Oh My Zsh and the `zsh-autosuggestions` / `zsh-syntax-highlighting` plugins |
| Zsh | Configures shell completions and plugins |
| Python | Installs Miniconda + uv, creates base conda environment with ruff/pytest/pre-commit |
| VS Code Insiders | Symlinks settings/keybindings, installs all extensions including ruff + Copilot |
| GitHub CLI | Installs the `gh-copilot` extension, checks auth status |
| Claude Code | Installs `@anthropic-ai/claude-code` via npm |
| Gemini CLI | Installs `@google/gemini-cli` via npm |
| OpenAI Codex | Installs `@openai/codex` via npm |
| macOS defaults | Applies sensible system preferences |
| Local stubs | Creates `~/.zshrc.local` and `~/.gitconfig.local` with API key placeholders |

> The install script is idempotent — safe to re-run at any time.

---

### Step 4 — Open a new terminal

```bash
source ~/.zshrc
# or just open a new terminal tab/window
```

---

### Step 5 — Authenticate AI & dev tools

#### GitHub CLI

```bash
gh auth login
# Choose: SSH protocol, GitHub.com
gh auth status    # verify
```

#### GitHub Copilot CLI

Installed automatically. After `gh auth login`:

```bash
ghcs 'how do I undo the last git commit'    # suggest a command
ghce 'git rebase -i HEAD~3'                 # explain a command
```

> Requires an active **GitHub Copilot subscription**.

#### Claude Code

```bash
claude
```

On first launch, Claude Code walks you through OAuth. Or set an API key in `~/.zshrc.local`:

```bash
export ANTHROPIC_API_KEY="sk-ant-..."
```

Get your key at <https://console.anthropic.com>.

#### Gemini CLI

```bash
gemini
```

Or set an API key in `~/.zshrc.local`:

```bash
export GEMINI_API_KEY="AIza..."
```

Get your key at <https://aistudio.google.com/apikey>.

#### OpenAI Codex CLI

Add to `~/.zshrc.local`:

```bash
export OPENAI_API_KEY="sk-..."
```

Then run `codex` to start an interactive session.

Get your key at <https://platform.openai.com/api-keys>.

---

## Python Workflow

This setup uses **Miniconda** for environment management and **uv** for fast package installation inside those environments. **Ruff** handles linting, formatting, and import sorting (replacing black, flake8, and isort).

### Creating a new project

```bash
pycreate myproject
```

Scaffolds `myproject/` with:
- `pyproject.toml` — ruff + mypy + pytest config
- `environment.yml` — conda env with Python 3.11 + uv
- `.pre-commit-config.yaml` — ruff, mypy, secret detection hooks
- `src/`, `tests/`, `docs/` directories

Then:

```bash
cd myproject
conda env create -f environment.yml
conda activate myproject
uv pip install -e '.[dev]'
pre-commit install
```

### Creating a quick environment

```bash
pyenv myenv          # Python 3.11 (default)
pyenv myenv 3.12     # specific version
```

### Installing packages with uv

Always use `uv pip install` inside conda environments for speed:

```bash
conda activate myenv
uv pip install pandas numpy scikit-learn
uv pip install -r requirements.txt
```

### Linting and formatting with ruff

```bash
rf          # lint
rff         # lint + auto-fix
rfmt        # format (black-compatible)
```

### Running pre-commit

```bash
pci         # pre-commit install (first time in a repo)
pc          # pre-commit run --all-files
pcu         # pre-commit autoupdate
```

---

## Shell Alias Reference

### AI Tools

| Alias | Command |
|-------|---------|
| `cl` | `claude` |
| `clc` | `claude --continue` |
| `clp` | `claude --print` |
| `gai` | `gemini` |
| `cdx` | `codex` |
| `ghcs` | `gh copilot suggest` |
| `ghce` | `gh copilot explain` |

### Python / uv / ruff

| Alias | Command |
|-------|---------|
| `ca` | `conda activate` |
| `cda` | `conda deactivate` |
| `clist` | `conda list` |
| `uvi` | `uv pip install` |
| `uvs` | `uv pip sync` |
| `rf` | `ruff check .` |
| `rff` | `ruff check . --fix` |
| `rfmt` | `ruff format .` |
| `pt` / `ptv` / `ptc` | pytest shortcuts |
| `mpy` | `mypy .` |
| `pc` / `pci` / `pcu` | pre-commit shortcuts |

### GitHub CLI

| Alias | Command |
|-------|---------|
| `ghprc` | `gh pr create` |
| `ghprl` | `gh pr list` |
| `ghprs` | `gh pr status` |
| `ghic` | `gh issue create` |
| `ghil` | `gh issue list` |
| `ghwl` | `gh run list` |

---

## Customization

### Local overrides (never committed)

**`~/.zshrc.local`** — loaded at the end of every shell session:

```bash
# API keys — never commit these
export ANTHROPIC_API_KEY="sk-ant-..."
export GEMINI_API_KEY="AIza..."
export OPENAI_API_KEY="sk-..."

# Machine-specific overrides
export PATH="$HOME/work/tools/bin:$PATH"
alias work='cd ~/work/mycompany'
```

**`~/.gitconfig.local`** — included by the main gitconfig:

```ini
[user]
    name = Your Name
    email = you@company.com
[credential]
    helper = osxkeychain
```

### Adding a new topic

```
mytool/
├── install.sh        # Runs during ./script/install
├── aliases.zsh       # Sourced into every shell session
└── mytool.conf.symlink  # Symlinked to ~/.mytool.conf
```

---

## Maintenance

### Update everything

```bash
dot update
```

Updates: Homebrew packages, Oh My Zsh, dotfiles repo, Claude Code, Gemini CLI, Codex CLI, uv, gh extensions, and VS Code extensions.

### Edit dotfiles

```bash
dot --edit    # opens ~/.dotfiles in VS Code Insiders
```

---

## Security

### What this repo does NOT contain

- No API keys, tokens, or passwords
- No SSH private keys
- No personal git credentials (those live in `~/.gitconfig.local`, which is gitignored)

### Security design

| Decision | Rationale |
|---|---|
| `~/.gitconfig.local` is gitignored | Name/email are personal; generated by bootstrap |
| `~/.zshrc.local` is gitignored | API keys and personal overrides live here |
| `git/gitignore.symlink` blocks `*.pem`, `*_rsa`, `.aws/`, `.ssh/`, `.env*` | Belt-and-suspenders secret protection |
| `detect-private-key` pre-commit hook | Catches accidental key inclusion before any commit |
| macOS Keychain for git credentials | No passwords stored in plaintext |

### Third-party install scripts

| Script | Source | What it does |
|---|---|---|
| Homebrew installer | `github.com/Homebrew/install` | Installs Homebrew |
| Oh My Zsh installer | `github.com/ohmyzsh/ohmyzsh` | Installs Oh My Zsh |
| uv installer (fallback only) | `astral.sh/uv/install.sh` | Only if `brew install uv` fails |

All other tools are installed via `npm install -g` or `brew install`.

### macOS defaults — is it safe?

All changes are reversible `defaults write` commands. No brick risk:

- The `killall` at the end only restarts UI apps (Finder, Dock, Safari, Terminal) — all relaunch automatically
- Does **not** touch: boot config, SIP, kernel extensions, network config, or nvram
- **LSQuarantine (Gatekeeper warning)** is **left enabled** — the line is commented out in `macos/set-defaults.sh` because it weakens a real security control

---

## Restoring from a Mac Backup

These scripts are designed to be **safe when run on a Mac that already has software installed** (e.g., migrated from a Time Machine backup or using Migration Assistant).

### What each script does when software already exists

| Script | Already installed behaviour |
|---|---|
| `homebrew/install.sh` | Skips Homebrew install; runs `brew bundle --no-upgrade` (installs missing packages only, does **not** upgrade existing ones) |
| `script/install` (Oh My Zsh) | Skips if `~/.oh-my-zsh` already exists |
| `script/install` (zsh plugins) | Skips if plugin directory already exists |
| `claude/install.sh` | Skips npm install if `claude` is on PATH |
| `gemini/install.sh` | Skips npm install if `gemini` is on PATH |
| `openai/install.sh` | Skips npm install if `codex` is on PATH |
| `github/install.sh` | Skips extension install if already present; skips auth prompt if already authed |
| `python/install.sh` | Updates (not replaces) the base conda env; skips if `uv` already installed |
| `vscode/install.sh` | `--install-extension` is idempotent — silently skips already-installed extensions |
| `script/bootstrap` (symlinks) | Detects existing files and prompts: skip / overwrite / backup |
| `macos/set-defaults.sh` | `defaults write` is idempotent — re-applying the same value is harmless |

### Recommended restore workflow

**Option A — Full fresh install** (wipe + reinstall macOS, then run dotfiles):
```bash
# Standard flow — see Quick Start above
./script/bootstrap && ./script/install
```

**Option B — Mac backup restore** (Migration Assistant or Time Machine, then run dotfiles):
```bash
# 1. Bootstrap: re-creates symlinks; prompts for any conflicts
./script/bootstrap

# 2. Install: missing tools are added; existing ones are left alone
./script/install

# 3. Check what brew bundle would change before actually running it
brew bundle check --file=~/.dotfiles/Brewfile
```

### What you may need to re-do after a restore

- **`gh auth login`** — GitHub CLI auth tokens don't survive machine migrations
- **`claude` / `gemini` / `codex` auth** — AI tool session tokens are machine-local; re-authenticate each
- **VS Code extensions** — Settings Sync usually restores these automatically if logged in to GitHub in VS Code Insiders
- **conda environments** — Project-specific environments are not part of this repo; recreate with `conda env create -f environment.yml` per project

### Potential conflict: existing `~/.zshrc`

If your restored Mac has a `~/.zshrc` that is not a symlink to these dotfiles, bootstrap will detect it and ask:

```
File already exists: ~/.zshrc, what do you want to do?
[s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?
```

Choose **`b` (backup)** to save the existing file to `~/.zshrc.backup` before symlinking, so you can merge any custom settings into `~/.zshrc.local` afterwards.

---

## Troubleshooting

### `command not found: brew`

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

On Apple Silicon, follow the post-install instructions to add brew to your PATH.

### `command not found: claude` / `codex` / `gemini`

```bash
npm install -g @anthropic-ai/claude-code
npm install -g @openai/codex
npm install -g @google/gemini-cli
```

### `command not found: uv`

```bash
brew install uv
```

### Symlinks point to wrong location

```bash
cd ~/.dotfiles && ./script/bootstrap
```

### VS Code extensions failed to install

Open VS Code Insiders → Command Palette → `Shell Command: Install 'code-insiders' command in PATH`. Then:

```bash
~/.dotfiles/vscode/install.sh
```

### ruff not formatting on save

```bash
code-insiders --install-extension charliermarsh.ruff
```

Verify `settings.json` has `"editor.defaultFormatter": "charliermarsh.ruff"` under `[python]`.

### conda not found after install

```bash
source ~/.zshrc
# or if that doesn't work:
conda init zsh && source ~/.zshrc
```

---

## Prerequisites Checklist

- [ ] macOS Monterey or newer
- [ ] Xcode Command Line Tools: `xcode-select --install`
- [ ] GitHub account (for `gh auth login` and Copilot)
- [ ] Anthropic account — <https://console.anthropic.com>
- [ ] Google account — <https://aistudio.google.com>
- [ ] OpenAI account — <https://platform.openai.com>

---

## License

MIT License. See [LICENSE.md](LICENSE.md) for details.
