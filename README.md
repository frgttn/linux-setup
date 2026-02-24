# Linux Setup

Personal Arch Linux post-install dotfiles and setup scripts.

---

## What it does

Running `install.sh` performs the following steps in order:

| Step | Description                                                    |
| ---- | -------------------------------------------------------------- |
| 1    | Install packages via **pacman** and **AUR (paru)**             |
| 2    | Install apps via **Flatpak** (Flathub)                         |
| 3    | Run extra scripts (`nvidia-fix.sh`, `install_mongodb_compass`) |
| 4    | Copy the `Wallpapers/` folder to `~/Pictures/`                 |
| 5    | Apply dotfiles with **GNU Stow** (`config/` → `~/.config/`)    |

---

## Installed packages

### pacman

| Package              | Description                                     |
| -------------------- | ----------------------------------------------- |
| `alacritty`          | GPU-accelerated terminal emulator               |
| `btop`               | Resource monitor                                |
| `chromium`           | Open-source web browser                         |
| `firefox`            | Web browser                                     |
| `fish`               | Friendly interactive shell                      |
| `flatpak`            | Flatpak runtime                                 |
| `fuse2`              | Filesystem in Userspace (required by some apps) |
| `nvtop`              | GPU process monitor                             |
| `opencode`           | AI coding agent for the terminal                |
| `starship`           | Cross-shell prompt                              |
| `stow`               | GNU Stow dotfile manager                        |
| `tmux`               | Terminal multiplexer                            |
| `tesseract`          | OCR engine                                      |
| `tesseract-data-eng` | OCR data — English                              |
| `tesseract-data-rus` | OCR data — Russian                              |
| `tesseract-data-ukr` | OCR data — Ukrainian                            |
| `zed`                | Code editor                                     |

### AUR (paru)

| Package                     | Description               |
| --------------------------- | ------------------------- |
| `microsoft-edge-stable-bin` | Microsoft Edge browser    |
| `visual-studio-code-bin`    | Visual Studio Code editor |

### Flatpak (Flathub)

| App           | Package ID                       |
| ------------- | -------------------------------- |
| Obsidian      | `md.obsidian.Obsidian`           |
| Bitwarden     | `com.bitwarden.desktop`          |
| Telegram      | `org.telegram.desktop`           |
| LibreOffice   | `org.libreoffice.LibreOffice`    |
| Discord       | `com.discordapp.Discord`         |
| FileZilla     | `org.filezillaproject.Filezilla` |
| Gear Lever    | `it.mijorus.gearlever`           |
| Google Chrome | `com.google.Chrome`              |
| Krita         | `org.kde.krita`                  |
| qBittorrent   | `org.qbittorrent.qBittorrent`    |
| RedisInsight  | `com.redis.RedisInsight`         |
| Zen Browser   | `app.zen_browser.zen`            |

---

## Dotfiles structure

Configs are managed with GNU Stow. All configs live in `config/` and get symlinked to `~/.config/`:

```
config/
├── starship.toml
├── alacritty/
├── fish/
└── tmux/
```

---

## How to run

### Prerequisites

- Arch Linux (or Arch-based distro)
- An active internet connection
- `git` installed

### Steps

```bash
# 1. Clone the repo
git clone https://github.com/frgttn/linux-setup.git
cd ./linux-setup

# 2. Make the installer executable (if not already)
chmod +x install.sh

# 3. Run
./install.sh
```

> The script uses `set -e`, so it will stop on any error. You can re-run it safely — pacman and paru skip already-installed packages.

---

## Extra scripts

Located in `scripts/`:

| Script                              | Description                        |
| ----------------------------------- | ---------------------------------- |
| `install_packages.sh`               | Installs pacman + AUR packages     |
| `install_packages_flatpak.sh`       | Installs Flatpak apps from Flathub |
| `nvidia-fix.sh`                     | Applies NVIDIA driver fixes        |
| `install_mongodb_compass_1_44.7.sh` | Installs MongoDB Compass 1.44.7    |

Each script can also be run independently:

```bash
bash scripts/nvidia-fix.sh
bash scripts/install_packages_flatpak.sh
```
