# Navigation shortcuts
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Shortcuts
alias d="cd ~/Documents"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/Documents/Projects"
alias g="git"

# List directory contents
alias ls="ls -G"
alias ll="ls -lh"
alias la="ls -lah"
alias l="ls -CF"

# Directory operations
alias mkdir="mkdir -p"

# System operations
alias reload!='. ~/.zshrc'
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Git shortcuts
alias gs="git status"
alias gc="git commit"
alias gd="git diff"
alias gl="git log"
alias gp="git push"
alias gpl="git pull"
alias ga="git add"
alias gb="git branch"
alias gco="git checkout"

# Docker shortcuts
alias dps="docker ps"
alias dimg="docker images"
alias dc="docker-compose"

# Python shortcuts
alias py="python"
alias py3="python3"
alias pip="pip3"
alias ve="python -m venv venv"
alias va="source venv/bin/activate"

# Tmux shortcuts
alias tn="tmux new -s"
alias ta="tmux attach -t"
alias tl="tmux ls"
alias tk="tmux kill-session -t"
