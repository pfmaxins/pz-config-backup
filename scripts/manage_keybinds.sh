#!/bin/bash
# manage_keybinds.sh – Backup or restore keybind files
# Usage: ./manage_keybinds.sh [backup|restore]

set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
KEYBINDS_DIR="$REPO_ROOT/Keybinds"
ZOMBOID_LUA="$HOME/Zomboid/Lua"
mkdir -p "$KEYBINDS_DIR" "$ZOMBOID_LUA"

show_help() {
  echo "Usage: $0 [backup|restore]"
  echo "  backup  – Copy keysB42.ini and keys.ini from ~/Zomboid/Lua/ to Keybinds/"
  echo "  restore – Copy keysB42.ini and keys.ini from Keybinds/ to ~/Zomboid/Lua/"
  exit 1
}

# Helper: backup a single file
backup_file() {
  local src="$1"
  local dest="$2"
  local name="$(basename "$src")"
  if [ ! -f "$src" ]; then
    echo "⚠️  $name not found, skipping."
    return
  fi
  if [ -f "$dest" ]; then
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    cp "$dest" "$dest.backup_$TIMESTAMP"
    echo "📦 Existing repo $name backed up to $dest.backup_$TIMESTAMP"
  fi
  cp "$src" "$dest"
  echo "✅ $name backed up to $dest"
}

# Helper: restore a single file
restore_file() {
  local src="$1"
  local dest="$2"
  local name="$(basename "$src")"
  if [ ! -f "$src" ]; then
    echo "⚠️  $name not found in repo, skipping."
    return
  fi
  if [ -f "$dest" ]; then
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    cp "$dest" "$dest.backup_$TIMESTAMP"
    echo "📦 Existing game $name backed up to $dest.backup_$TIMESTAMP"
  fi
  cp "$src" "$dest"
  echo "✅ $name restored to $dest"
}

backup() {
  backup_file "$ZOMBOID_LUA/keysB42.ini" "$KEYBINDS_DIR/keysB42.ini"
  backup_file "$ZOMBOID_LUA/keys.ini" "$KEYBINDS_DIR/keys.ini"
  echo "✅ All keybind files backed up."
}

restore() {
  restore_file "$KEYBINDS_DIR/keysB42.ini" "$ZOMBOID_LUA/keysB42.ini"
  restore_file "$KEYBINDS_DIR/keys.ini" "$ZOMBOID_LUA/keys.ini"
  echo "✅ All keybind files restored."
}

case "$1" in
backup) backup ;;
restore) restore ;;
*) show_help ;;
esac
