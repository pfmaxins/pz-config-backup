#!/bin/bash
# restore_user.sh – Restore user configs from repo to ~/Zomboid

set -e
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
USER_BACKUP_DIR="$REPO_ROOT/User"
ZOMBOID_DIR="$HOME/Zomboid"

if [ ! -d "$USER_BACKUP_DIR" ]; then
  echo "ERROR: User backup directory not found at $USER_BACKUP_DIR"
  exit 1
fi

mkdir -p "$ZOMBOID_DIR"

# Restore options.ini
if [ -f "$USER_BACKUP_DIR/options.ini" ]; then
  if [ -f "$ZOMBOID_DIR/options.ini" ]; then
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    mv "$ZOMBOID_DIR/options.ini" "$ZOMBOID_DIR/options_backup_$TIMESTAMP.ini"
    echo "Backed up existing options.ini"
  fi
  cp "$USER_BACKUP_DIR/options.ini" "$ZOMBOID_DIR/options.ini"
  echo "✅ options.ini restored"
fi

# Restore keybindings.ini
if [ -f "$USER_BACKUP_DIR/keybindings.ini" ]; then
  if [ -f "$ZOMBOID_DIR/keybindings.ini" ]; then
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    mv "$ZOMBOID_DIR/keybindings.ini" "$ZOMBOID_DIR/keybindings_backup_$TIMESTAMP.ini"
    echo "Backed up existing keybindings.ini"
  fi
  cp "$USER_BACKUP_DIR/keybindings.ini" "$ZOMBOID_DIR/keybindings.ini"
  echo "✅ keybindings.ini restored"
fi

echo "✅ User configs restored from $USER_BACKUP_DIR"
