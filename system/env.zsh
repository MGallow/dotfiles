# Environment variables

# Set default editors
export EDITOR='code-insiders --wait'
export VISUAL='code-insiders --wait'

# Set language and locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# History is configured in zsh/history.zsh

# Less configuration
export LESS="-R"
export LESS_TERMCAP_md=$'\e[1;33m'

# Don't clear the screen after quitting a manual page
export MANPAGER="less -X"

# Make Python use UTF-8 encoding for output to stdin/stdout/stderr
export PYTHONIOENCODING='UTF-8'
