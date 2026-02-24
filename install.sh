#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── 1. Packages ───────────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════"
echo " [1/6] Installing packages"
echo "════════════════════════════════════"
bash "$SCRIPT_DIR/scripts/install_packages.sh"

# ── 2. Flatpak ────────────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════"
echo " [2/6] Installing Flatpak packages"
echo "════════════════════════════════════"
bash "$SCRIPT_DIR/scripts/install_packages_flatpak.sh"

# ── 3. Extra scripts ──────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════"
echo " [3/6] Running extra scripts"
echo "════════════════════════════════════"
bash "$SCRIPT_DIR/scripts/nvidia-fix.sh"
bash "$SCRIPT_DIR/scripts/install_mongodb_compass_1_44.7.sh"

# ── 3. Wallpapers ─────────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════"
echo " [4/6] Copying wallpapers"
echo "════════════════════════════════════"
mkdir -p ~/Pictures
cp -r "$SCRIPT_DIR/Wallpapers" ~/Pictures/
echo "Wallpapers copied to ~/Pictures"

# ── 5. Fonts ──────────────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════"
echo " [5/6] Copying fonts"
echo "════════════════════════════════════"
mkdir -p ~/.local/share/fonts
cp -r "$SCRIPT_DIR/fonts/." ~/.local/share/fonts/
fc-cache -f ~/.local/share/fonts
echo "Fonts copied to ~/.local/share/fonts"

# ── 6. GNU Stow ───────────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════"
echo " [6/6] Applying GNU Stow"
echo "════════════════════════════════════"
mkdir -p ~/.config
stow -d "$SCRIPT_DIR" -t ~/.config config
echo "Stow applied: config → ~/.config"

echo ""
echo "════════════════════════════════════"
echo " All done!"
echo "════════════════════════════════════"