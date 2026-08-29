#!/bin/bash
# backup_saves.sh – Creates a compressed backup of ~/Zomboid/Saves

ZOMBOID_DIR="$HOME/Zomboid"
SAVES_DIR="$ZOMBOID_DIR/Saves"
BACKUP_DIR="$ZOMBOID_DIR/Backups"

if [ ! -d "$SAVES_DIR" ]; then
  echo "No Saves folder found. Nothing to backup."
  exit 0
fi

mkdir -p "$BACKUP_DIR"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="saves_backup_$TIMESTAMP.tar.gz"
ARCHIVE_PATH="$BACKUP_DIR/$ARCHIVE_NAME"

echo "Compressing $SAVES_DIR to $ARCHIVE_PATH ..."
tar -czf "$ARCHIVE_PATH" -C "$ZOMBOID_DIR" "Saves"

echo "✅ Backup saved to $ARCHIVE_PATH"
