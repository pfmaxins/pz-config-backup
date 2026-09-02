#!/bin/bash
# install_server.sh – Clones the Server config from GitHub into ~/Zomboid/Server

set -e
ZOMBOID_DIR="$HOME/Zomboid"
SERVER_DIR="$ZOMBOID_DIR/Server"

mkdir -p "$ZOMBOID_DIR"

# Backup existing Server folder if present
if [ -d "$SERVER_DIR" ]; then
  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
  mv "$SERVER_DIR" "$ZOMBOID_DIR/Server_backup_$TIMESTAMP"
  echo "Backed up existing Server to Server_backup_$TIMESTAMP"
fi

TEMP_DIR=$(mktemp -d -t pz_install_XXXXXX)
cd "$TEMP_DIR"

echo "Downloading repository..."
if command -v curl &>/dev/null; then
  curl -L -o repo.zip "https://github.com/pfmaxins/pz-config-backup/archive/refs/heads/main.zip"
elif command -v wget &>/dev/null; then
  wget -O repo.zip "https://github.com/pfmaxins/pz-config-backup/archive/refs/heads/main.zip"
else
  echo "ERROR: curl or wget required."
  exit 1
fi

unzip -q repo.zip
SOURCE_SERVER="pz-config-backup-main/Server"
if [ ! -d "$SOURCE_SERVER" ]; then
  echo "ERROR: Server folder not found in repository."
  exit 1
fi

cp -r "$SOURCE_SERVER" "$SERVER_DIR"
cd && rm -rf "$TEMP_DIR"

echo "✅ Server config installed to $SERVER_DIR"
