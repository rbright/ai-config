# Use bash with strict error checking
set shell := ["bash", "-uc"]

# Allow passing arguments to recipes
set positional-arguments

# Show available recipes with their descriptions
default:
    @just --list

# Install all configs, or pass packages (e.g. `just install codex`).
install *PACKAGES:
    if [[ -z "{{PACKAGES}}" ]]; then \
        stow -R claude codex opencode; \
        scripts/codex-sync-config.sh; \
      else \
        stow -R {{PACKAGES}}; \
        if [[ " {{PACKAGES}} " == *" codex "* ]]; then \
          scripts/codex-sync-config.sh; \
        fi; \
      fi

# Restow a specific package (e.g. `just stow codex`).
stow PACKAGE:
    stow -R {{PACKAGE}}

# Remove a specific package (e.g. `just unstow codex`).
unstow PACKAGE:
    stow -D {{PACKAGE}}

# Sync the repo-managed Codex config.toml into ~/.codex/config.toml as a real file (not a symlink).
codex-sync-config:
    scripts/codex-sync-config.sh

# Run a high-recall Codex review of the working tree (staged + unstaged + untracked).
codex-review:
    codex/.codex/skills/pre-review-gate/scripts/codex_review_thorough.sh --uncommitted
