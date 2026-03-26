#!/usr/bin/env bash
#
# Zsh setup — Oh My Zsh and plugins
# Note: script/install also calls this logic with RUNZSH=no CHSH=no set.
# This file exists for standalone use; script/install is the primary entry point.

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "  Installing Oh My Zsh..."
    # RUNZSH=no prevents Oh My Zsh from immediately replacing the current shell
    # CHSH=no prevents it from attempting to change the default shell (we do that manually)
    # Security note: This runs the official Oh My Zsh installer directly from GitHub.
    # Source: https://github.com/ohmyzsh/ohmyzsh/blob/master/tools/install.sh
    # Alternative: clone the repo manually and run tools/install.sh locally.
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Install zsh-autosuggestions plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "  Installing zsh-autosuggestions..."
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
        "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# Install zsh-syntax-highlighting plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "  Installing zsh-syntax-highlighting..."
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

echo "  Zsh setup complete."
