# Git aliases and functions

# Use `hub` as git wrapper if available
if (( $+commands[hub] )); then
  alias git=hub
fi

# Git shortcuts
alias gst='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gl='git pull'
alias gp='git push'
alias gpf!='git push --force'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gd='git diff'
alias gds='git diff --staged'
alias glg='git log --graph --decorate --oneline'
alias glo='git log --oneline'
alias grh='git reset'
alias grhh='git reset --hard'
alias gcl='git clone'
alias gclean='git clean -fd'
alias grm='git rm'
alias grmc='git rm --cached'
alias gss='git stash save'
alias gsp='git stash pop'
alias gsl='git stash list'

# Function to get current branch
git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

# Function to create and push a new branch
gnb() {
  if [ $# -ne 1 ]; then
    echo "Usage: gnb <branch-name>"
    return 1
  fi
  
  git checkout -b "$1" && git push -u origin "$1"
}