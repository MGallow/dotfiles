# Dotfiles

A collection of dotfiles and scripts to customize and improve your development environment on macOS. This repository includes configurations for:

- Zsh with Oh My Zsh
- Git
- Vim
- VS Code (including settings, keybindings, and snippets)
- VS Code Insiders (optional)
- Tmux
- Homebrew
- macOS system preferences
- Python development environment
- GitHub Copilot settings

## Quick Start

1. Clone this repository:

```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
```

2. Run the bootstrap script:

```bash
cd ~/.dotfiles
./script/bootstrap
```

3. Install dependencies and applications:

```bash
./script/install
```

## What's Inside

### Core Components

- **Zsh**: Custom shell configuration with Oh My Zsh
  - Optimized history settings
  - Git-aware prompt
  - Smart aliases and functions
- **Git**:
  - Global git configuration template
  - Useful aliases
  - SSH configuration
- **VS Code**:
  - Optimized settings for Python/Data Science
  - GitHub theme and VS Code icons
  - GitHub Copilot configuration
  - Jupyter notebook preferences
  - Custom keybindings
- **Python Environment**:
  - Miniconda setup
  - Common data science packages
  - Black formatter configuration
  - Pytest settings
- **Terminal Tools**:
  - Tmux configuration
  - SSH key management
  - Custom terminal functions

### Security Features

- Templates for sensitive information
- Gitignored local config files
- SSH key management
- No hardcoded personal information

### Key Commands

- `dot`: Manage your dotfiles
  - `dot update`: Update packages and configurations
  - `dot edit`: Edit dotfiles in VS Code
- `c`: Smart directory navigation
- `zssh`: Enhanced SSH with key management

## Customization

### Local Configuration

1. Git (copy and edit with your details):

```bash
cp git/gitconfig.local.example ~/.gitconfig.local
```

2. VS Code:

- Settings sync is enabled by default
- Local machine-specific settings go in `~/.vscode-local`

### Adding Your Own Settings

1. Create a new topic folder
2. Add `.symlink` files to be linked to home
3. Add `install.sh` for topic-specific setup
4. Add `.zsh` files for shell customization

## Maintenance

### Updating

```bash
dot update
```

This will:

- Update Homebrew packages
- Update Oh My Zsh
- Pull latest dotfiles changes
- Rebuild symlinks if needed

### Backup

Your old dotfiles are automatically backed up to `~/.dotfiles_backup` during installation.

## Prerequisites

- macOS (Monterey or newer recommended)
- Git
- Command Line Tools for Xcode

## License

MIT License. See [LICENSE.md](LICENSE.md) for details.
