# Path configurations

# Add ~/bin to PATH if it exists
if [[ -d "$HOME/bin" ]]; then
  export PATH="$HOME/bin:$PATH"
fi

# Add ~/.local/bin to PATH if it exists
if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# Add user's private bin if it exists
if [[ -d "$HOME/.dotfiles/bin" ]]; then
  export PATH="$HOME/.dotfiles/bin:$PATH"
fi

# Homebrew paths
if [[ -d "/opt/homebrew/bin" ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
fi

if [[ -d "/opt/homebrew/sbin" ]]; then
  export PATH="/opt/homebrew/sbin:$PATH"
fi
