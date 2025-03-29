# ZSH plugin configuration

# Define plugins array
plugins=(
  git
  dotenv
  docker-compose
  docker
  tmux
  python
  vscode
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Load Oh My Zsh plugins if they're enabled
if [ "$ZSH" ]; then
  # The plugins are already sourced in oh-my-zsh.sh, 
  # so we don't need to do anything additional here
  # This file merely defines the plugins array for reference
  :
fi