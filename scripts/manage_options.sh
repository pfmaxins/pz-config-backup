#!/bin/bash
# manage_options.sh – Backup or restore ~/Zomboid/options.ini
# Usage: ./manage_options.sh [backup|restore]

set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
USER_DIR="$REPO_ROOT/User"
ZOMBOID_DIR="$HOME/Zomboid"
OPTIONS_SRC="$ZOMBOID_DIR/options.ini"
OPTIONS_DEST="$USER_DIR/options.ini"

mkdir -p "$USER_DIR"

show_help() {
  echo "Usage: $0 [backup|restore]"
  echo "  backup  – Copy options.ini from ~/Zomboid/ to User/options.ini"
  echo "  restore – Copy options.ini from User/options.ini to ~/Zomboid/"
  exit 1
}

backup() {
  if [ ! -f "$OPTIONS_SRC" ]; then
    echo "⚠️  No options.ini found in $ZOMBOID_DIR. Nothing to backup."
    exit 0
  fi
  # Backup existing repo file if present
  if [ -f "$OPTIONS_DEST" ]; then
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    cp "$OPTIONS_DEST" "$USER_DIR/options_backup_$TIMESTAMP.ini"
    echo "📦 Existing repo options.ini backed up to options_backup_$TIMESTAMP.ini"
  fi
  cp "$OPTIONS_SRC" "$OPTIONS_DEST"
  echo "✅ options.ini backed up to $OPTIONS_DEST"
}

restore() {
  if [ ! -f "$OPTIONS_DEST" ]; then
    echo "⚠️  No options.ini found in repo's User/ folder. Nothing to restore."
    exit 0
  fi
  # Backup existing game file if present
  if [ -f "$OPTIONS_SRC" ]; then
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    cp "$OPTIONS_SRC" "$ZOMBOID_DIR/options_backup_$TIMESTAMP.ini"
    echo "📦 Existing game options.ini backed up to options_backup_$TIMESTAMP.ini"
  fi
  cp "$OPTIONS_DEST" "$OPTIONS_SRC"
  echo "✅ options.ini restored to $OPTIONS_SRC"
}

case "$1" in
backup) backup ;;
restore) restore ;;
*) show_help ;;
esac
