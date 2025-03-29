#!/bin/bash

# Check for Homebrew and install if not found
if test ! $(which brew); then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ $(uname -m) == "arm64" ]]; then
    # For Apple Silicon Macs
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

# Update Homebrew recipes
brew update

# Install all dependencies from Brewfile
brew bundle install --file="$DOTFILES/Brewfile"

# Remove outdated versions
brew cleanup
