# Use bash with strict error checking
set shell := ["bash", "-uc"]

# Allow passing arguments to recipes
set positional-arguments

# Show available recipes with their descriptions
default:
    @just --list

# Install all configs, or pass packages (e.g. `just install codex`).
install *PACKAGES:
    @set -euo pipefail; \
      if [[ -z "{{PACKAGES}}" ]]; then \
        stow -R agents claude codex opencode >/dev/null; \
        scripts/codex-sync-config.sh >/dev/null; \
        echo "Installed: agents claude codex opencode (codex synced)"; \
      else \
        stow -R {{PACKAGES}} >/dev/null; \
        if [[ " {{PACKAGES}} " == *" codex "* ]]; then \
          scripts/codex-sync-config.sh >/dev/null; \
          echo "Installed: {{PACKAGES}} (codex synced)"; \
        else \
          echo "Installed: {{PACKAGES}}"; \
        fi; \
      fi

# Restow a specific package (e.g. `just stow codex`).
stow PACKAGE:
    stow -R {{PACKAGE}}

# Remove a specific package (e.g. `just unstow codex`).
unstow PACKAGE:
    stow -D {{PACKAGE}}

# Sync repo-managed configs that require copy-based installs (e.g. Codex config.toml).
sync *PACKAGES:
    @set -euo pipefail; \
      if [[ -z "{{PACKAGES}}" ]]; then \
      echo "Usage: just sync codex" >&2; \
      exit 1; \
    fi; \
    if [[ " {{PACKAGES}} " == *" codex "* ]]; then \
      scripts/codex-sync-config.sh >/dev/null; \
    fi; \
    for pkg in {{PACKAGES}}; do \
      if [[ "${pkg}" != "codex" ]]; then \
        echo "No sync task for ${pkg}" >&2; \
      fi; \
    done; \
    if [[ " {{PACKAGES}} " == *" codex "* ]]; then \
      echo "Synced: codex"; \
    fi

# Run a high-recall Codex review of the working tree (staged + unstaged + untracked).
codex-review:
    codex/.codex/skills/pre-review-gate/scripts/codex_review_thorough.sh --uncommitted
