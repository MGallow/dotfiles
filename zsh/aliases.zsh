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

# Docker shortcuts
alias dps="docker ps"
alias dimg="docker images"
alias dc="docker-compose"

# Tmux shortcuts
alias tn="tmux new -s"
alias ta="tmux attach -t"
alias tl="tmux ls"
alias tk="tmux kill-session -t"
