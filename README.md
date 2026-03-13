# Dotfiles

A collection of dotfiles and scripts to set up a complete macOS development environment from scratch. One command gets you from a bare Mac to a fully configured workstation.

**Includes out-of-the-box configuration for:**

| Tool | Purpose |
|---|---|
| Zsh + Oh My Zsh | Shell with plugins, themes, and smart aliases |
| Git | Global config, aliases, and global ignore rules |
| Vim / Tmux | Terminal editor and multiplexer |
| VS Code (+ Insiders) | Editor with 75+ extensions pre-installed |
| GitHub CLI (`gh`) | GitHub from the terminal |
| GitHub Copilot (VS Code + CLI) | AI pair programmer in editor and shell |
| Claude Code (`claude`) | Anthropic's AI coding agent in the terminal |
| Gemini CLI (`gemini`) | Google's AI assistant in the terminal |
| Python / Miniconda | Data science stack with Black, pytest, mypy |
| Homebrew | macOS package manager |
| macOS defaults | Sensible system preferences |

---

## Prerequisites

Before you begin, make sure you have:

1. **macOS Monterey (12) or newer** — tested on Monterey, Ventura, Sonoma, Sequoia
2. **Xcode Command Line Tools** — provides `git` and build tools

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
claude
gemini
```

---

## Step-by-Step Setup

### Step 1 — Clone the repository

```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

> The repo is expected to live at `~/.dotfiles`. Other paths work but you may need to update `$DOTFILES` in `zsh/zshrc.symlink`.

---

### Step 2 — Run the bootstrap script

```bash
./script/bootstrap
```

This will:
- Prompt you for your **Git author name and email** (used in `~/.gitconfig.local`)
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
| Python | Installs Miniconda and creates the base conda environment |
| VS Code | Symlinks settings/keybindings, installs all extensions including GitHub Copilot |
| GitHub CLI | Installs the `gh-copilot` extension, checks auth status |
| Claude Code | Installs the `@anthropic-ai/claude-code` npm package |
| Gemini CLI | Installs the `@google/gemini-cli` npm package |
| macOS defaults | Applies sensible system preferences (Finder, Dock, keyboard, etc.) |
| Local stubs | Creates `~/.zshrc.local` and `~/.gitconfig.local` with commented placeholders |

> **Tip:** The install script is idempotent — safe to re-run at any time.

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
```

Follow the interactive prompts. Choose **HTTPS** for the protocol and **GitHub.com** as the host. A browser window will open to complete OAuth.

Verify it worked:

```bash
gh auth status
```

#### GitHub Copilot CLI

The `gh-copilot` extension is installed automatically. After `gh auth login` it's ready:

```bash
ghcs 'how do I undo the last git commit'    # suggest a command
ghce 'git rebase -i HEAD~3'                 # explain a command
```

> You need an active **GitHub Copilot subscription** (individual, team, or enterprise).

#### Claude Code

```bash
claude
```

On first launch, Claude Code will walk you through authentication via your **Anthropic Console** account. You can also set an API key directly:

```bash
# Add to ~/.zshrc.local (already scaffolded for you)
export ANTHROPIC_API_KEY="sk-ant-..."
```

Get your key at <https://console.anthropic.com>.

Verify it worked:

```bash
claude --version
```

#### Gemini CLI

```bash
gemini
```

On first launch, Gemini CLI will authenticate via Google. You can also use an API key:

```bash
# Add to ~/.zshrc.local
export GEMINI_API_KEY="AIza..."
```

Get your key at <https://aistudio.google.com/apikey>.

---

## What's Installed

### Homebrew Packages

See [`Brewfile`](Brewfile) for the full list. Key packages:

| Package | Why |
|---------|-----|
| `git` + `git-lfs` | Version control |
| `gh` | GitHub CLI + Copilot extension |
| `node` | Runtime for Claude Code and Gemini CLI |
| `fzf` | Fuzzy finder (used by zsh history search) |
| `ripgrep` | Fast code search (`rg`) |
| `bat` | Syntax-highlighted `cat` |
| `eza` | Modern `ls` with icons |
| `zoxide` | Smarter `cd` (learns your dirs) |
| `tmux` | Terminal multiplexer |

### VS Code Extensions

All extensions are installed for both **VS Code** and **VS Code Insiders**. Highlights:

- `github.copilot` + `github.copilot-chat` — AI pair programmer
- `ms-python.python` + `ms-python.vscode-pylance` — Python language support
- `ms-toolsai.jupyter` — Jupyter notebooks
- `ms-vscode-remote.remote-ssh` — Remote development
- `eamodio.gitlens` — Enhanced Git history/blame
- `github.vscode-pull-request-github` — PR reviews in editor

### Shell Aliases

#### AI Tools

| Alias | Command |
|-------|---------|
| `cl` | `claude` |
| `clc` | `claude --continue` |
| `clp` | `claude --print` |
| `gai` | `gemini` |
| `ghcs` | `gh copilot suggest` |
| `ghce` | `gh copilot explain` |

#### Git

| Alias | Command |
|-------|---------|
| `gst` | `git status` |
| `gc` | `git commit` |
| `gco` | `git checkout` |
| `gb` | `git branch` |
| `glg` | `git log --graph` |
| `gnb` | Create + push new branch |

#### GitHub CLI

| Alias | Command |
|-------|---------|
| `ghprc` | `gh pr create` |
| `ghprl` | `gh pr list` |
| `ghprs` | `gh pr status` |
| `ghic` | `gh issue create` |
| `ghil` | `gh issue list` |
| `ghwl` | `gh run list` |

#### Python

| Alias | Command |
|-------|---------|
| `ca` | `conda activate` |
| `pt` | `pytest` |
| `ptv` | `pytest -v` |
| `ptc` | `pytest --cov` |
| `bl` | `black .` |

---

## Customization

### Local overrides (never committed)

Two files are created but gitignored — put machine-specific config here:

**`~/.zshrc.local`** — loaded at the end of every shell session:

```bash
# API keys
export ANTHROPIC_API_KEY="sk-ant-..."
export GEMINI_API_KEY="AIza..."

# Machine-specific PATH additions
export PATH="$HOME/work/tools/bin:$PATH"

# Work-specific aliases
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

Each tool lives in its own directory (a "topic"). To add your own:

```
mytool/
├── install.sh        # Runs during ./script/install
├── aliases.zsh       # Sourced into every shell session
└── mytool.conf.symlink  # Symlinked to ~/.mytool.conf
```

- Any `*.symlink` file is linked to `~/.<basename>` during `./script/bootstrap`
- Any `*.zsh` file is sourced automatically by `.zshrc`
- Any `install.sh` is executed by `./script/install`

---

## Maintenance

### Update everything

```bash
dot update
```

This will:
1. `brew update && brew upgrade && brew cleanup`
2. Update Oh My Zsh
3. `git pull` the dotfiles repo
4. `npm update -g @anthropic-ai/claude-code`
5. `npm update -g @google/gemini-cli`
6. `gh extension upgrade --all`
7. Update all VS Code extensions

### Edit dotfiles

```bash
dot --edit    # opens ~/.dotfiles in VS Code
```

### Re-run install after pulling changes

```bash
cd ~/.dotfiles && ./script/install
```

---

## Directory Structure

```
~/.dotfiles/
├── bin/              # Utility scripts added to $PATH
│   ├── dot           # Dotfiles manager (dot update, dot --edit)
│   ├── c             # Directory bookmarking
│   ├── e             # Smart editor launcher
│   ├── zssh          # SSH with auto key loading
│   └── ...
├── claude/           # Claude Code CLI
│   ├── install.sh
│   └── aliases.zsh
├── gemini/           # Gemini CLI
│   ├── install.sh
│   └── aliases.zsh
├── git/              # Git config and aliases
├── github/           # GitHub CLI + Copilot CLI
│   ├── install.sh
│   └── aliases.zsh
├── homebrew/         # Homebrew installer
├── macos/            # macOS system defaults
├── python/           # Miniconda + data science stack
├── script/
│   ├── bootstrap     # Creates symlinks, prompts for Git identity
│   └── install       # Full installation orchestrator
├── system/           # PATH, env vars, system aliases
├── tmux/             # Tmux config
├── vim/              # Vim config
├── vscode/           # VS Code settings, keybindings, extensions
├── zsh/              # Zsh config, plugins, aliases, functions
├── Brewfile          # Homebrew package manifest
└── README.md
```

---

## Troubleshooting

### `command not found: brew`

Homebrew wasn't installed or isn't on your PATH yet. Run:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then follow the instructions Homebrew prints at the end (it will tell you to add a line to your shell profile).

### `command not found: claude` / `command not found: gemini`

Node wasn't on PATH when the install ran, or npm install failed. Fix:

```bash
npm install -g @anthropic-ai/claude-code
npm install -g @google/gemini-cli
```

### `gh: command not found`

Homebrew didn't install `gh`. Run:

```bash
brew install gh
```

### Symlinks point to wrong location

Re-run the bootstrap:

```bash
cd ~/.dotfiles && ./script/bootstrap
```

### macOS says "cannot be opened because the developer cannot be verified"

Run this to remove the quarantine attribute:

```bash
xattr -d com.apple.quarantine ~/.dotfiles/script/install
xattr -d com.apple.quarantine ~/.dotfiles/script/bootstrap
```

### VS Code extensions failed to install

Make sure `code` is on your PATH. Open VS Code → **Command Palette** → `Shell Command: Install 'code' command in PATH`. Then re-run:

```bash
~/.dotfiles/vscode/install.sh
```

---

## Security Notes

- **Never commit API keys.** Use `~/.zshrc.local` (gitignored) for secrets.
- The `.gitignore` at the root blocks common secret files (`.env`, `.pem`, `.aws/`, `.ssh/`, etc.)
- Pre-commit hooks detect private keys before any accidental commit.
- Git credentials are stored in the macOS Keychain (`osxkeychain` helper).

---

## Prerequisites Checklist

Before running `./script/install`, ensure:

- [ ] macOS Monterey or newer
- [ ] Xcode Command Line Tools: `xcode-select --install`
- [ ] GitHub account (for `gh auth login` and Copilot)
- [ ] Anthropic account (for Claude Code) — <https://console.anthropic.com>
- [ ] Google account (for Gemini CLI) — <https://aistudio.google.com>

---

## License

MIT License. See [LICENSE.md](LICENSE.md) for details.
