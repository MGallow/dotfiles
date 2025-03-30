# Directory navigation wrapper
# This turns the 'c' script into a function that can change your directory

c() {
  if [ "$1" = "add" ] || [ "$1" = "remove" ] || [ "$1" = "-h" ] || [ "$1" = "--help" ] || [ -z "$1" ]; then
    # For these commands, just run the script
    $DOTFILES/bin/c "$@"
  else
    # For directory navigation, run the script and evaluate its output
    cd $($DOTFILES/bin/c "$@")
  fi
}
