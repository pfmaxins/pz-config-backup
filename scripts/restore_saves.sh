#!/bin/bash
# restore_saves.sh – Restore a backup from Backups/ to ~/Zomboid/Saves

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BACKUP_DIR="$REPO_ROOT/Backups"
SAVES_DIR="$HOME/Zomboid/Saves"

if [ ! -d "$BACKUP_DIR" ]; then
  echo "No Backups directory found."
  exit 1
fi

BACKUPS=($(ls -t "$BACKUP_DIR"/saves_*.tar.gz 2>/dev/null))
if [ ${#BACKUPS[@]} -eq 0 ]; then
  echo "No saves_*.tar.gz archives found in $BACKUP_DIR."
  exit 1
fi

echo "Available backups:"
for i in "${!BACKUPS[@]}"; do
  echo "  $((i + 1)). $(basename "${BACKUPS[$i]}")"
done

read -p "Select a backup number (or 0 to cancel): " SELECTION
if [[ ! "$SELECTION" =~ ^[0-9]+$ ]] || [ "$SELECTION" -eq 0 ] || [ "$SELECTION" -gt ${#BACKUPS[@]} ]; then
  echo "Cancelled."
  exit 0
fi

SELECTED="${BACKUPS[$((SELECTION - 1))]}"
echo "Restoring $SELECTED ..."

read -p "This will replace the current Saves folder. Continue? (y/n): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
  echo "Cancelled."
  exit 0
fi

rm -rf "$SAVES_DIR"
mkdir -p "$(dirname "$SAVES_DIR")"
tar -xzf "$SELECTED" -C "$HOME/Zomboid"

echo "✅ Restored from $(basename "$SELECTED")"
