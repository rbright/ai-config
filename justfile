# Use bash with strict error checking

set shell := ["bash", "-uc"]

# Allow passing arguments to recipes

set positional-arguments := true

codex_skills := "pre-review-gate gh-address-bot-feedback commit-and-pr update-docs update-agent-instructions"
codex_skills_ignore_regex := "^(?!(pre-review-gate|gh-address-bot-feedback|commit-and-pr|update-docs|update-agent-instructions)(/|$)).*"

# Install all configs, or pass packages (e.g. `just install codex`).
install *PACKAGES:
    @set -euo pipefail; \
      mkdir -p "$HOME/.agents/skills" "$HOME/.codex/skills" "$HOME/.config/claude/skills"; \
      if [[ -z "{{ PACKAGES }}" ]]; then \
        stow -R agents claude codex opencode >/dev/null; \
        for skill in {{ codex_skills }}; do \
          target="$HOME/.codex/skills/$skill"; \
          if [[ -L "$target" ]]; then rm -f "$target"; fi; \
          if [[ -d "$target" ]]; then \
            if find "$target" -mindepth 1 ! -type l ! -type d -print -quit | grep -q .; then \
              echo "Skipping $target (contains non-symlink files)" >&2; \
              continue; \
            fi; \
            rm -rf "$target"; \
          fi; \
        done; \
        stow -R --dir=agents/.agents --target="$HOME/.codex/skills" --ignore='{{ codex_skills_ignore_regex }}' skills >/dev/null; \
        scripts/codex-sync-config.sh >/dev/null; \
        echo "Installed: agents claude codex opencode (codex synced)"; \
      else \
        stow -R {{ PACKAGES }} >/dev/null; \
        if [[ " {{ PACKAGES }} " == *" codex "* ]]; then \
          for skill in {{ codex_skills }}; do \
            target="$HOME/.codex/skills/$skill"; \
            if [[ -L "$target" ]]; then rm -f "$target"; fi; \
            if [[ -d "$target" ]]; then \
              if find "$target" -mindepth 1 ! -type l ! -type d -print -quit | grep -q .; then \
                echo "Skipping $target (contains non-symlink files)" >&2; \
                continue; \
              fi; \
              rm -rf "$target"; \
            fi; \
          done; \
          stow -R --dir=agents/.agents --target="$HOME/.codex/skills" --ignore='{{ codex_skills_ignore_regex }}' skills >/dev/null; \
          scripts/codex-sync-config.sh >/dev/null; \
        fi; \
        echo "Installed: {{ PACKAGES }}"; \
      fi

# Uninstall all configs, or pass packages (e.g. `just uninstall codex`).
uninstall *PACKAGES:
    @set -euo pipefail; \
      if [[ -z "{{ PACKAGES }}" ]]; then \
        if [[ -d "$HOME/.codex/skills" ]]; then \
          stow -D --dir=agents/.agents --target="$HOME/.codex/skills" --ignore='{{ codex_skills_ignore_regex }}' skills >/dev/null; \
        fi; \
        stow -D agents claude codex opencode >/dev/null; \
        echo "Uninstalled: agents claude codex opencode"; \
      else \
        if [[ " {{ PACKAGES }} " == *" codex "* ]]; then \
          if [[ -d "$HOME/.codex/skills" ]]; then \
            stow -D --dir=agents/.agents --target="$HOME/.codex/skills" --ignore='{{ codex_skills_ignore_regex }}' skills >/dev/null; \
          fi; \
        fi; \
        stow -D {{ PACKAGES }} >/dev/null; \
        echo "Uninstalled: {{ PACKAGES }}"; \
      fi
