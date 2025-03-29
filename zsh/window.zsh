# ZSH terminal window title configuration

# Set terminal window title based on current directory and running command
# This helps identify different terminal windows easily

# Window title function
function set_window_title() {
  local TITLE="\033]0;"
  TITLE+="${USER}@${HOST%%.*}: "
  TITLE+="${PWD/#$HOME/~}"
  TITLE+="\007"
  echo -ne "$TITLE"
}

# Update title before showing the prompt
precmd_functions+=(set_window_title)

# Update title before executing a command
function title_preexec() {
  local TITLE="\033]0;"
  TITLE+="${USER}@${HOST%%.*}: "
  TITLE+="${PWD/#$HOME/~} - $1"
  TITLE+="\007"
  echo -ne "$TITLE"
}

preexec_functions+=(title_preexec)