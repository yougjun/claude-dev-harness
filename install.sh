#!/bin/bash
set -euo pipefail

CLAUDE_DIR="$HOME/.claude"
AGENTS_DIR="$CLAUDE_DIR/agents"
SKILLS_DIR="$CLAUDE_DIR/skills"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Claude Dev Harness Installer ==="
echo ""

mkdir -p "$AGENTS_DIR" "$SKILLS_DIR"

CONFLICTS=()
for f in "$SCRIPT_DIR"/agents/*.md; do
    name=$(basename "$f")
    if [ -f "$AGENTS_DIR/$name" ]; then
        CONFLICTS+=("agents/$name")
    fi
done
for d in "$SCRIPT_DIR"/skills/*/; do
    name=$(basename "$d")
    if [ -d "$SKILLS_DIR/$name" ]; then
        CONFLICTS+=("skills/$name/")
    fi
done

if [ ${#CONFLICTS[@]} -gt 0 ]; then
    echo "Existing files detected:"
    for c in "${CONFLICTS[@]}"; do
        echo "  - $c"
    done
    echo ""
    read -p "Overwrite? (y/N): " answer
    if [[ ! "$answer" =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 1
    fi
    BACKUP_DIR="$CLAUDE_DIR/backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR/agents" "$BACKUP_DIR/skills"
    for c in "${CONFLICTS[@]}"; do
        src="$CLAUDE_DIR/$c"
        if [ -f "$src" ]; then
            cp "$src" "$BACKUP_DIR/$c"
        elif [ -d "$src" ]; then
            cp -r "$src" "$BACKUP_DIR/$c"
        fi
    done
    echo "Backup created: $BACKUP_DIR"
fi

echo "Installing agents..."
cp "$SCRIPT_DIR"/agents/*.md "$AGENTS_DIR/"
echo "  $(ls "$SCRIPT_DIR"/agents/*.md | wc -l) agents installed"

echo "Installing skills..."
for d in "$SCRIPT_DIR"/skills/*/; do
    name=$(basename "$d")
    cp -r "$d" "$SKILLS_DIR/$name"
done
echo "  $(ls -d "$SCRIPT_DIR"/skills/*/ | wc -l) skills installed"

echo ""
echo "Done! Installed to $CLAUDE_DIR"
echo ""
echo "Next steps:"
echo "  1. Add the harness pointer to your project's CLAUDE.md"
echo "     (see templates/CLAUDE.md.template)"
echo "  2. Start Claude Code and try a non-trivial task"
