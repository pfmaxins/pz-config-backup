#!/bin/bash
# pz_tools.sh – Main menu for Project Zomboid config tools
# Usage: ./pz_tools.sh

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
NC='\033[0m' # No Color

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
SCRIPTS_DIR="$REPO_ROOT/scripts"

# Ensure scripts are executable
chmod +x "$SCRIPTS_DIR"/*.sh 2>/dev/null || true

clear

# ASCII Art Header
echo -e "${CYAN}${BOLD}"
echo "  ╔══════════════════════════════════════════════════════════╗"
echo "  ║                                                          ║"
echo "  ║     ██████╗ ███████╗    ████████╗ ██████╗  ██████╗ ██╗  ║"
echo "  ║     ██╔══██╗╚══███╔╝    ╚══██╔══╝██╔═══██╗██╔═══██╗██║  ║"
echo "  ║     ██████╔╝  ███╔╝        ██║   ██║   ██║██║   ██║██║  ║"
echo "  ║     ██╔═══╝  ███╔╝         ██║   ██║   ██║██║   ██║██║  ║"
echo "  ║     ██║     ███████╗       ██║   ╚██████╔╝╚██████╔╝████╗║"
echo "  ║     ╚═╝     ╚══════╝       ╚═╝    ╚═════╝  ╚═════╝ ╚═══╝║"
echo "  ║                                                          ║"
echo "  ║              Project Zomboid Config Tools                ║"
echo "  ╚══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${YELLOW}Repo: $REPO_ROOT${NC}"
echo ""

# Menu loop
while true; do
  echo -e "${BOLD}${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
  echo -e "${BOLD}${BLUE}│${NC}  ${BOLD}MAIN MENU${NC}                                            ${BOLD}${BLUE}│${NC}"
  echo -e "${BOLD}${BLUE}├─────────────────────────────────────────────────────┤${NC}"
  echo -e "${BOLD}${BLUE}│${NC}  ${GREEN}1${NC}) Install Server Config (from repo to ~/Zomboid)    ${BOLD}${BLUE}│${NC}"
  echo -e "${BOLD}${BLUE}│${NC}  ${GREEN}2${NC}) Backup Player Saves (to repo/Backups)            ${BOLD}${BLUE}│${NC}"
  echo -e "${BOLD}${BLUE}│${NC}  ${GREEN}3${NC}) Restore Player Saves (from repo/Backups)         ${BOLD}${BLUE}│${NC}"
  echo -e "${BOLD}${BLUE}│${NC}  ${GREEN}4${NC}) Backup User Options (options.ini to repo/User)   ${BOLD}${BLUE}│${NC}"
  echo -e "${BOLD}${BLUE}│${NC}  ${GREEN}5${NC}) Restore User Options (from repo/User)            ${BOLD}${BLUE}│${NC}"
  echo -e "${BOLD}${BLUE}│${NC}  ${GREEN}6${NC}) Backup Keybinds (keys*.ini to repo/Keybinds)    ${BOLD}${BLUE}│${NC}"
  echo -e "${BOLD}${BLUE}│${NC}  ${GREEN}7${NC}) Restore Keybinds (from repo/Keybinds)           ${BOLD}${BLUE}│${NC}"
  echo -e "${BOLD}${BLUE}│${NC}  ${GREEN}8${NC}) Install Keybinds (to ~/Zomboid/Lua)              ${BOLD}${BLUE}│${NC}"
  echo -e "${BOLD}${BLUE}│${NC}  ${GREEN}0${NC}) Exit                                              ${BOLD}${BLUE}│${NC}"
  echo -e "${BOLD}${BLUE}└─────────────────────────────────────────────────────┘${NC}"
  echo ""
  echo -e "${YELLOW}Enter your choice (0-8):${NC} "
  read -r CHOICE

  case $CHOICE in
  1)
    echo -e "${CYAN}Installing Server Config...${NC}"
    "$SCRIPTS_DIR/install_server.sh"
    echo ""
    ;;
  2)
    echo -e "${CYAN}Backing up Player Saves...${NC}"
    "$SCRIPTS_DIR/backup_saves.sh"
    echo ""
    ;;
  3)
    echo -e "${CYAN}Restoring Player Saves...${NC}"
    "$SCRIPTS_DIR/restore_saves.sh"
    echo ""
    ;;
  4)
    echo -e "${CYAN}Backing up User Options...${NC}"
    "$SCRIPTS_DIR/manage_options.sh" backup
    echo ""
    ;;
  5)
    echo -e "${CYAN}Restoring User Options...${NC}"
    "$SCRIPTS_DIR/manage_options.sh" restore
    echo ""
    ;;
  6)
    echo -e "${CYAN}Backing up Keybinds...${NC}"
    "$SCRIPTS_DIR/manage_keybinds.sh" backup
    echo ""
    ;;
  7)
    echo -e "${CYAN}Restoring Keybinds...${NC}"
    "$SCRIPTS_DIR/manage_keybinds.sh" restore
    echo ""
    ;;
  8)
    echo -e "${CYAN}Installing Keybinds to ~/Zomboid/Lua...${NC}"
    "$SCRIPTS_DIR/install_keybinds.sh"
    echo ""
    ;;
  0)
    echo -e "${GREEN}Goodbye!${NC}"
    exit 0
    ;;
  *)
    echo -e "${RED}Invalid choice. Please enter a number between 0 and 8.${NC}"
    sleep 1
    ;;
  esac

  # Pause before showing menu again
  echo -e "${YELLOW}Press any key to continue...${NC}"
  read -r -n 1 -s
  clear

  # Re-display header (shortened version)
  echo -e "${CYAN}${BOLD}  ╔══════════════════════════════════════════════════════════╗${NC}"
  echo -e "${CYAN}${BOLD}  ║              Project Zomboid Config Tools                ║${NC}"
  echo -e "${CYAN}${BOLD}  ╚══════════════════════════════════════════════════════════╝${NC}"
  echo ""
done
