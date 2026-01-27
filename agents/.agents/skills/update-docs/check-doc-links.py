#!/usr/bin/env python3
"""
Lightweight Markdown link checker (relative links only).

Goal: prevent documentation rot by failing fast when we introduce links to files that don't exist.

This script intentionally does NOT validate:
- external links (http/https)
- section anchors within a file
- links inside code fences
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

INLINE_LINK_RE = re.compile(r"!?\[[^\]]*\]\(([^)]+)\)")


def _iter_markdown_files(repo_root: Path) -> list[Path]:
    # Keep this list small and obvious; this is not meant to perfectly mirror every tool's exclude list.
    excluded_dir_names = {
        ".git",
        ".venv",
        ".uv",
        "node_modules",
        "dist",
        "build",
        "unloads",
    }

    files: list[Path] = []
    for path in repo_root.rglob("*.md"):
        if any(part in excluded_dir_names for part in path.parts):
            continue
        files.append(path)
    return files


def _strip_code_fences(text: str) -> str:
    """
    Remove fenced code blocks (``` / ~~~) to avoid false positives from markdown-like snippets.

    This is a simple state machine; it is not a full markdown parser.
    """

    out_lines: list[str] = []
    in_fence = False
    fence_token = ""

    for line in text.splitlines():
        stripped = line.lstrip()
        if stripped.startswith("```") or stripped.startswith("~~~"):
            token = stripped[:3]
            if not in_fence:
                in_fence = True
                fence_token = token
            elif token == fence_token:
                in_fence = False
                fence_token = ""
            continue

        if not in_fence:
            out_lines.append(line)

    return "\n".join(out_lines)


def _normalize_link_target(raw_target: str) -> str | None:
    target = raw_target.strip()
    if not target:
        return None

    # Markdown links may include an optional title: (path/to/doc.md "title")
    # We only want to validate the filesystem path portion.
    title_start = re.search(r"\s+(?=[\"'\(])", target)
    if title_start:
        target = target[: title_start.start()].strip()
        if not target:
            return None

    # Markdown sometimes wraps URLs in angle brackets: (<https://example.com>)
    if target.startswith("<") and target.endswith(">"):
        target = target[1:-1].strip()

    if target.startswith(("http://", "https://", "mailto:", "tel:")):
        return None

    if target.startswith("#"):
        return None

    # Strip anchors and query params for filesystem resolution.
    target = target.split("#", 1)[0].split("?", 1)[0].strip()
    if not target:
        return None

    return target


def _find_repo_root(start: Path) -> Path:
    current = start
    while current != current.parent:
        if (current / ".git").exists():
            return current
        current = current.parent
    return start


def main() -> int:
    repo_root = _find_repo_root(Path.cwd().resolve())
    markdown_files = _iter_markdown_files(repo_root)

    errors: list[str] = []
    skipped_decode_errors: list[Path] = []
    scanned_files = 0

    for md_path in markdown_files:
        try:
            text = md_path.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            # We only scan markdown. If a file isn't UTF-8, skip it rather than failing the whole repo,
            # but surface which file was skipped so this doesn't silently hide issues.
            skipped_decode_errors.append(md_path)
            continue
        scanned_files += 1

        text = _strip_code_fences(text)

        for match in INLINE_LINK_RE.finditer(text):
            raw_target = match.group(1)
            target = _normalize_link_target(raw_target)
            if target is None:
                continue

            if target.startswith("/"):
                resolved = repo_root / target.lstrip("/")
            else:
                resolved = md_path.parent / target

            if not resolved.exists():
                rel_md = md_path.relative_to(repo_root)
                errors.append(f"{rel_md}: broken link target: {raw_target!r} (resolved to {resolved})")

    if errors:
        print("Broken documentation links detected:\n", file=sys.stderr)
        for err in sorted(errors):
            print(f"- {err}", file=sys.stderr)
        print(f"\nTotal: {len(errors)} broken links", file=sys.stderr)
        return 1

    if skipped_decode_errors:
        print(
            f"Note: skipped {len(skipped_decode_errors)} markdown file(s) due to UTF-8 decode errors:",
            file=sys.stderr,
        )
        for path in sorted(skipped_decode_errors):
            print(f"- {path.relative_to(repo_root)}", file=sys.stderr)

    print(f"OK: scanned {scanned_files}/{len(markdown_files)} markdown files; no broken relative links found")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
