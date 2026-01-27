#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Run a comprehensive Codex CLI review with high-recall prompt + stricter settings.

Usage:
  codex_review_thorough.sh --uncommitted
  codex_review_thorough.sh --base <branch>
  codex_review_thorough.sh --commit <sha>

Notes:
  - Uses a bundled prompt template (references/codex_review_prompt.md)
  - Forces high verbosity + high reasoning effort via `codex -c ...`
EOF
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPT_FILE="${SCRIPT_DIR}/../references/codex_review_prompt.md"

if [[ ! -f "${PROMPT_FILE}" ]]; then
  echo "ERROR: missing prompt file: ${PROMPT_FILE}" >&2
  exit 2
fi

if [[ $# -eq 0 ]]; then
  usage >&2
  exit 2
fi

cmd=(
  codex
  review
  -c 'model_verbosity="high"'
  -c 'model_reasoning_effort="xhigh"'
)

preamble=""

case "${1}" in
  -h|--help)
    usage
    exit 0
    ;;
  --uncommitted)
    preamble="Review target: full working tree changes (staged + unstaged + untracked)."
    shift
    ;;
  --base)
    if [[ $# -lt 2 ]]; then
      echo "ERROR: --base requires a branch name" >&2
      exit 2
    fi
    preamble="Review target: PR-shaped diff vs base branch '${2}' (plus any local uncommitted changes if present)."
    shift 2
    ;;
  --commit)
    if [[ $# -lt 2 ]]; then
      echo "ERROR: --commit requires a sha" >&2
      exit 2
    fi
    preamble="Review target: commit '${2}'. Gather changes using \`git show ${2}\` (and adjacent context as needed)."
    shift 2
    ;;
  *)
    echo "ERROR: unknown option: ${1}" >&2
    usage >&2
    exit 2
    ;;
esac

if [[ $# -ne 0 ]]; then
  echo "ERROR: unexpected extra arguments: $*" >&2
  usage >&2
  exit 2
fi

cmd+=(-)
{
  echo "${preamble}"
  echo
  cat "${PROMPT_FILE}"
} | "${cmd[@]}"
