# Dotfiles Makefile — thin wrapper around script/*
# Run 'make help' to see available targets.

SHELL := /bin/bash
DOTFILES := $(shell pwd)

.PHONY: help bootstrap install verify update unlink dry-run defaults sync sync-on sync-off sync-status sync-log

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}'

bootstrap: ## Create symlinks and generate local configs (first-time setup)
	@cd $(DOTFILES) && ./script/bootstrap

install: ## Install all packages and tools (runs after bootstrap)
	@cd $(DOTFILES) && ./script/install

verify: ## Check that the installation is healthy
	@cd $(DOTFILES) && ./script/verify

update: ## Update all packages, AI tools, and Oh My Zsh
	@cd $(DOTFILES) && ./bin/dot update

unlink: ## Remove all managed dotfile symlinks (reverse of bootstrap)
	@cd $(DOTFILES) && ./script/unlink

dry-run: ## Preview what bootstrap would do without making changes
	@cd $(DOTFILES) && ./script/bootstrap --dry-run

defaults: ## Apply macOS system preferences (manual — not run by install)
	@cd $(DOTFILES) && ./macos/set-defaults.sh

sync: ## Run a one-off sync with remote now
	@cd $(DOTFILES) && ./bin/dot sync

sync-on: ## Enable automatic background sync (fswatch + launchd)
	@cd $(DOTFILES) && ./bin/dot sync-on

sync-off: ## Disable automatic background sync
	@cd $(DOTFILES) && ./bin/dot sync-off

sync-status: ## Show whether auto-sync is running
	@cd $(DOTFILES) && ./bin/dot sync-status

sync-log: ## Tail the sync log
	@cd $(DOTFILES) && ./bin/dot sync-log
