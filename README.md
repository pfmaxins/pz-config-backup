## 📖 Overview

This toolkit helps you manage **Project Zomboid** configurations across **Windows** and **Linux**. It handles:

- **Server configs** (`servertest.ini`, etc.)  
- **Player saves** (your character data, professions, skills, inventory)  
- **User options** (`options.ini` – graphics, audio, gameplay)  
- **Keybinds** (`keysB42.ini` / `keys.ini` – custom controls)

All operations are **non‑destructive** – they automatically back up existing files before making changes.

---

## ✨ Features

- **Cross‑platform** – PowerShell for Windows, Bash for Linux/macOS/WSL  
- **One‑click main menu** – runs all scripts from a single, colorful interface  
- **Safe backups** – timestamps are added to backups so you never lose data  
- **Repo‑centric** – all backups are stored **inside this repository**, making it easy to version and push to GitHub  
- **Modular scripts** – each tool can be run individually or through the main menu  

---

## 📂 Repository Structure

```
pz-config-backup/
├── pz_tools.sh                 # Main menu (Linux/macOS)
├── pz_tools.ps1                # Main menu (Windows)
├── Server/                     # Server config files (source for installation)
│   ├── servertest.ini
│   └── ServerOptions.ini
├── User/                       # User options (backup/restore)
│   ├── options.ini             # (created by backup)
│   └── options_backup_*.ini    # automatic backups
├── Keybinds/                   # Keybind files (backup/restore)
│   ├── keysB42.ini             # Build 42 keybinds
│   ├── keys.ini                # Build 41 keybinds (if used)
│   └── *.backup_*              # automatic backups
├── Backups/                    # Player save archives (created by backup_saves)
│   └── saves_*.tar.gz          # timestamped backups
└── scripts/                    # All tools
    ├── install_server.*        # copy Server/ to ~/Zomboid/Server
    ├── backup_saves.*          # compress ~/Zomboid/Saves -> Backups/
    ├── restore_saves.*         # extract a backup into ~/Zomboid/Saves
    ├── manage_options.*        # backup/restore options.ini
    ├── manage_keybinds.*       # backup/restore keybind files
    └── install_keybinds.*      # copy Keybinds/ to ~/Zomboid/Lua/
```

---

## 📋 Prerequisites

- **Git** (to clone this repository)  
- **For Linux/macOS/WSL**: Bash, `curl` or `wget`, `unzip` (most systems have these)  
- **For Windows**: PowerShell (preinstalled on Windows 7+) – no extra downloads needed  

---

## 🚀 Quick Start – The Main Menu (Recommended)

### Linux / macOS / WSL
```bash
# Clone the repository
git clone https://github.com/yourusername/pz-config-backup.git
cd pz-config-backup

# Make the main menu executable
chmod +x pz_tools.sh

# Run it
./pz_tools.sh
```

### Windows (PowerShell)
```powershell
# Clone the repository (using Git Bash, or download ZIP and extract)
cd C:\path\to\pz-config-backup

# Run the menu (you may need to allow script execution)
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\pz_tools.ps1
```

The menu will present numbered options. Simply type the number and press Enter.

---

## 🛠️ Individual Scripts (Expert Use)

If you prefer to run scripts directly, here is what each does:

| Script (Linux) | Script (Windows) | Action |
| :--- | :--- | :--- |
| `install_server.sh` | `install_server.ps1` | Copies `Server/` from repo to `~/Zomboid/Server` (backup first) |
| `backup_saves.sh` | `backup_saves.ps1` | Archives `~/Zomboid/Saves` into `Backups/saves_*.tar.gz` |
| `restore_saves.sh` | `restore_saves.ps1` | Interactively restores a selected saves backup |
| `manage_options.sh backup` | `manage_options.ps1 backup` | Copies `~/Zomboid/options.ini` to `User/options.ini` |
| `manage_options.sh restore` | `manage_options.ps1 restore` | Copies `User/options.ini` back to `~/Zomboid/` |
| `manage_keybinds.sh backup` | `manage_keybinds.ps1 backup` | Copies `~/Zomboid/Lua/keys*.ini` to `Keybinds/` |
| `manage_keybinds.sh restore` | `manage_keybinds.ps1 restore` | Copies `Keybinds/*.ini` back to `~/Zomboid/Lua/` |
| `install_keybinds.sh` | *(not provided)* | Installs keybinds to `~/Zomboid/Lua/` (Linux only) |

---

## 🤖 For AI Assistants

If you are an AI helping a user, here is how you can generate commands:

### 1. Determine the user's OS
- If they say "Windows" → use PowerShell scripts (`.ps1`)  
- If they say "Linux", "macOS", or "WSL" → use Bash scripts (`.sh`)  

### 2. Identify what they want to do

| User intent | Command to suggest |
| :--- | :--- |
| "Install the server config" | `cd /path/to/repo && ./pz_tools.sh` (or run `install_server` directly) |
| "Backup my player saves" | `cd /path/to/repo && ./scripts/backup_saves.sh` |
| "Restore my saves" | `cd /path/to/repo && ./scripts/restore_saves.sh` |
| "Backup my options" | `cd /path/to/repo && ./scripts/manage_options.sh backup` |
| "Restore my options" | `cd /path/to/repo && ./scripts/manage_options.sh restore` |
| "Backup my keybinds" | `cd /path/to/repo && ./scripts/manage_keybinds.sh backup` |
| "Restore my keybinds" | `cd /path/to/repo && ./scripts/manage_keybinds.sh restore` |
| "Install custom keybinds" (Linux) | `cd /path/to/repo && ./scripts/install_keybinds.sh` |
| "Open the main menu" | `cd /path/to/repo && ./pz_tools.sh` (or `.ps1` on Windows) |

**Important:** Always remind the user to navigate to the repository folder first (`cd /path/to/pz-config-backup`).  

**For Windows PowerShell**, they may need to run `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass` before running any `.ps1` script to bypass security restrictions.

---

## ⚠️ Safety & Troubleshooting

- **Backups are automatic** – every script that overwrites a file first creates a timestamped copy of the existing file.  
- **Player saves are heavy** – backup archives can be large. Use Git LFS or exclude `Backups/` from commits if needed.  
- **Mod changes can break saves** – restoring old saves after changing mods may cause errors. Always test on a backup server first.  
- **If the main menu doesn't run**:  
  - Linux: `chmod +x pz_tools.sh` and ensure `scripts/*.sh` are executable.  
  - Windows: Right‑click the `.ps1` file and select "Run with PowerShell", or run from a terminal.

---

## 📦 Contributing / Updating

This repo is designed to be **your personal configuration store**. Feel free to:

- Add your own server configs to `Server/`  
- Keep your `User/options.ini` and `Keybinds/` up to date  
- Push backups to GitHub for safekeeping (but watch file sizes)

---

## 📄 License

This toolkit is provided as-is – use it at your own risk. Always back up your important data manually as well.

---

**Happy surviving!** 🧟‍♂️
