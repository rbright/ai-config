#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Sync the repo-managed Codex config into ~/.codex/config.toml as a REAL FILE (not a symlink).

Why: Codex rewrites ~/.codex/config.toml and will replace symlinks with a new regular file.

Usage:
  scripts/codex-sync-config.sh

Behavior:
  - Creates ~/.codex if needed
  - If ~/.codex/config.toml exists, saves a timestamped backup next to it
  - Removes ~/.codex/config.toml if it is a symlink, then copies the repo version in
  - Sets permissions to 600
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

SOURCE="${REPO_ROOT}/codex/.codex/config.toml"
TARGET_DIR="${HOME}/.codex"
TARGET="${TARGET_DIR}/config.toml"

if [[ ! -f "${SOURCE}" ]]; then
  echo "ERROR: repo config not found: ${SOURCE}" >&2
  exit 2
fi

mkdir -p "${TARGET_DIR}"

ts="$(date +"%Y%m%d%H%M%S")"

if [[ -e "${TARGET}" || -L "${TARGET}" ]]; then
  backup="${TARGET}.bak.${ts}"
  cp -p "${TARGET}" "${backup}" 2>/dev/null || cp "${TARGET}" "${backup}"
  echo "BACKUP: ${backup}"
fi

if [[ -L "${TARGET}" ]]; then
  rm -f "${TARGET}"
fi

cp -p "${SOURCE}" "${TARGET}" 2>/dev/null || cp "${SOURCE}" "${TARGET}"
chmod 600 "${TARGET}"

echo "SYNCED: ${SOURCE} -> ${TARGET}"
