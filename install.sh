#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── 1. Packages ───────────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════"
echo " [1/5] Installing packages"
echo "════════════════════════════════════"
bash "$SCRIPT_DIR/scripts/install_packages.sh"

# ── 2. Flatpak ────────────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════"
echo " [2/5] Installing Flatpak packages"
echo "════════════════════════════════════"
bash "$SCRIPT_DIR/scripts/install_packages_flatpak.sh"

# ── 3. Extra scripts ──────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════"
echo " [3/5] Running extra scripts"
echo "════════════════════════════════════"
bash "$SCRIPT_DIR/scripts/nvidia-fix.sh"
bash "$SCRIPT_DIR/scripts/install_mongodb_compass_1_44.7.sh"

# ── 3. Wallpapers ─────────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════"
echo " [4/5] Copying wallpapers"
echo "════════════════════════════════════"
mkdir -p ~/Pictures
cp -r "$SCRIPT_DIR/Wallpapers" ~/Pictures/
echo "Wallpapers copied to ~/Pictures"

# ── 4. GNU Stow ───────────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════"
echo " [5/5] Applying GNU Stow"
echo "════════════════════════════════════"
mkdir -p ~/.config
stow -d "$SCRIPT_DIR" -t ~/.config config
echo "Stow applied: config → ~/.config"

echo ""
echo "════════════════════════════════════"
echo " All done!"
echo "════════════════════════════════════"