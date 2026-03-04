# ZSH History configuration

# History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

# Record timestamp of command in HISTFILE
setopt EXTENDED_HISTORY

# Share history between sessions
setopt SHARE_HISTORY

# Add commands to history as they are typed, don't wait until shell exits
setopt INC_APPEND_HISTORY

# Expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST

# Don't store duplications
setopt HIST_IGNORE_DUPS

# Ignore duplicates when searching
setopt HIST_FIND_NO_DUPS

# Remove blank lines from history
setopt HIST_REDUCE_BLANKS

# Ignore commands that start with space
setopt HIST_IGNORE_SPACE

# Show command with history expansion before running it
setopt HIST_VERIFY

# Append to history file
setopt APPEND_HISTORY
