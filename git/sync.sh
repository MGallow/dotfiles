#!/usr/bin/env bash
#
# git/sync.sh — Auto-sync dotfiles with remote
#
# Pulls remote changes, auto-commits any local modifications, and pushes.
# Triggered by launchd on file changes (WatchPaths) and on a 5-minute
# timer (StartInterval). Can also be run standalone via `dot sync`.
#
# Safety guarantees:
#   • Never force-pushes
#   • Aborts on merge conflicts (leaves repo in a safe state for manual fix)
#   • Skips gracefully when offline or remote is unreachable
#   • Logs all actions to ~/Library/Logs/dotfiles-sync.log

set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
LOGFILE="$HOME/Library/Logs/dotfiles-sync.log"
BRANCH="main"
REMOTE="origin"

mkdir -p "$(dirname "$LOGFILE")"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOGFILE"
}

die() {
    log "ERROR: $1"
    exit 1
}

# ── Pre-flight checks ─────────────────────────────────────────────────────────

cd "$DOTFILES" || die "Cannot cd to $DOTFILES"

# Ensure we're in a git repo
git rev-parse --is-inside-work-tree &>/dev/null || die "Not a git repository"

# Ensure we're on the expected branch
current_branch=$(git symbolic-ref --short HEAD 2>/dev/null)
if [[ "$current_branch" != "$BRANCH" ]]; then
    log "SKIP: On branch '$current_branch', expected '$BRANCH'"
    exit 0
fi

# Ensure no rebase/merge/cherry-pick is in progress
if [[ -d .git/rebase-merge ]] || [[ -d .git/rebase-apply ]] || [[ -f .git/MERGE_HEAD ]]; then
    log "SKIP: Rebase or merge in progress"
    exit 0
fi

# Check connectivity (quick DNS check to avoid long timeouts)
if ! host github.com &>/dev/null; then
    log "SKIP: No network connectivity to github.com"
    exit 0
fi

# ── Pull remote changes ───────────────────────────────────────────────────────

log "Starting sync..."

# Fetch latest
if ! git fetch "$REMOTE" "$BRANCH" --quiet 2>/dev/null; then
    log "SKIP: Could not fetch from $REMOTE"
    exit 0
fi

# Check for upstream changes and merge (fast-forward only)
local_sha=$(git rev-parse HEAD)
remote_sha=$(git rev-parse "$REMOTE/$BRANCH")
base_sha=$(git merge-base HEAD "$REMOTE/$BRANCH")

if [[ "$local_sha" != "$remote_sha" ]] && [[ "$local_sha" == "$base_sha" ]]; then
    # We are behind remote — fast-forward
    if git merge --ff-only "$REMOTE/$BRANCH" --quiet 2>/dev/null; then
        log "PULLED: Fast-forwarded to $REMOTE/$BRANCH"
    else
        log "SKIP: Fast-forward merge failed — manual intervention needed"
        exit 0
    fi
elif [[ "$local_sha" != "$remote_sha" ]] && [[ "$remote_sha" == "$base_sha" ]]; then
    # We are ahead — will push below
    log "INFO: Local is ahead of remote, will push"
elif [[ "$local_sha" != "$remote_sha" ]]; then
    # Diverged — don't auto-resolve, just log
    log "SKIP: Local and remote have diverged — manual merge needed"
    exit 0
fi

# ── Auto-commit local changes ─────────────────────────────────────────────────

# Stage all changes (respects .gitignore)
git add -A

# Check if there's anything to commit
if ! git diff --cached --quiet; then
    # Build a meaningful commit message
    changed_files=$(git diff --cached --name-only | head -5)
    file_count=$(git diff --cached --name-only | wc -l | tr -d ' ')

    if [[ "$file_count" -eq 1 ]]; then
        msg="auto-sync: update $(echo "$changed_files" | head -1)"
    else
        first_file=$(echo "$changed_files" | head -1)
        msg="auto-sync: update $first_file (+$((file_count - 1)) more)"
    fi

    git commit -m "$msg" --quiet
    log "COMMITTED: $msg"
fi

# ── Push to remote ─────────────────────────────────────────────────────────────

local_sha=$(git rev-parse HEAD)
remote_sha=$(git rev-parse "$REMOTE/$BRANCH")

if [[ "$local_sha" != "$remote_sha" ]]; then
    if git push "$REMOTE" "$BRANCH" --quiet 2>/dev/null; then
        log "PUSHED: to $REMOTE/$BRANCH"
    else
        log "ERROR: Push failed — check remote permissions"
        exit 1
    fi
else
    log "OK: Already in sync"
fi
