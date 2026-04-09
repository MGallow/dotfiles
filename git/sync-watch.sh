#!/usr/bin/env bash
#
# git/sync-watch.sh — fswatch-based dotfiles auto-sync daemon
#
# Watches the dotfiles directory for changes and triggers sync.sh with
# debouncing (waits for a quiet period before syncing to batch rapid edits).
# Also pulls from remote on a periodic interval to catch remote changes.
#
# Designed to run as a launchd daemon via `dot sync-on`.

set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
LOGFILE="$HOME/Library/Logs/dotfiles-sync.log"
SYNC_SCRIPT="$DOTFILES/git/sync.sh"
DEBOUNCE_SEC=5          # Wait this long after last change before syncing
PULL_INTERVAL_SEC=300   # Pull from remote every 5 minutes regardless

mkdir -p "$(dirname "$LOGFILE")"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] WATCH: $1" >> "$LOGFILE"
}

# ── Pre-flight ─────────────────────────────────────────────────────────────────

if ! command -v fswatch &>/dev/null; then
    log "ERROR: fswatch not found — install with: brew install fswatch"
    echo "ERROR: fswatch not installed. Run: brew install fswatch" >&2
    exit 1
fi

cd "$DOTFILES" || exit 1

log "Starting fswatch watcher on $DOTFILES (debounce=${DEBOUNCE_SEC}s, pull every ${PULL_INTERVAL_SEC}s)"

# ── Sync with lock to prevent overlapping runs ────────────────────────────────

LOCKFILE="/tmp/dotfiles-sync.lock"

run_sync() {
    # Simple lock to avoid overlapping syncs
    if [ -f "$LOCKFILE" ]; then
        lock_pid=$(cat "$LOCKFILE" 2>/dev/null)
        if kill -0 "$lock_pid" 2>/dev/null; then
            log "SKIP: Sync already in progress (pid $lock_pid)"
            return
        fi
        rm -f "$LOCKFILE"
    fi

    echo $$ > "$LOCKFILE"
    bash "$SYNC_SCRIPT"
    rm -f "$LOCKFILE"
}

# ── Cleanup on exit ───────────────────────────────────────────────────────────

cleanup() {
    log "Watcher stopping (received signal)"
    rm -f "$LOCKFILE"
    # Kill background jobs (fswatch, periodic pull loop)
    kill 0 2>/dev/null || true
    exit 0
}
trap cleanup SIGTERM SIGINT SIGHUP EXIT

# ── Periodic remote pull (background) ─────────────────────────────────────────
# fswatch only detects local changes, so we periodically pull to catch remote
# changes (e.g., edits pushed from another machine).

(
    while true; do
        sleep "$PULL_INTERVAL_SEC"
        log "Periodic remote pull triggered"
        run_sync
    done
) &

# ── Watch for local changes (foreground) ──────────────────────────────────────
# Filters:
#   --exclude '.git'       → ignore git internals
#   --latency $DEBOUNCE    → batch rapid changes (natural debounce)
#   --one-per-batch        → one event per batch of changes
#   --recursive            → watch subdirectories

fswatch \
    --recursive \
    --exclude '\.git' \
    --latency "$DEBOUNCE_SEC" \
    --one-per-batch \
    "$DOTFILES" \
| while read -r _event; do
    log "File change detected — syncing"
    run_sync
done
