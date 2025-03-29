# Add directories to fpath to enable tab completion for custom functions

# Add dotfiles custom completions to fpath if the directory exists
if [[ -d "$DOTFILES/zsh-comps" ]]; then
  fpath=("$DOTFILES/zsh-comps" $fpath)
fi

# Add any custom functions to fpath
if [[ -d "$DOTFILES/functions" ]]; then
  fpath=("$DOTFILES/functions" $fpath)
fi

# Autoload all functions in the functions directory
if [[ -d "$DOTFILES/functions" ]]; then
  for function_file in $DOTFILES/functions/*; do
    if [[ -f "$function_file" && ! "$function_file" =~ "\.zwc$" ]]; then
      autoload -Uz $(basename "$function_file")
    fi
  done
fi