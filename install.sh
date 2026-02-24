#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── 1. Packages ───────────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════"
echo " [1/7] Installing packages"
echo "════════════════════════════════════"
bash "$SCRIPT_DIR/scripts/install_packages.sh"

# ── 2. Fish shell ─────────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════"
echo " [2/8] Setting up Fish shell"
echo "════════════════════════════════════"
command -v fish | sudo tee -a /etc/shells
chsh -s "$(command -v fish)"
echo "Fish set as default shell"

# ── 3. Flatpak ────────────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════"
echo " [3/8] Installing Flatpak packages"
echo "════════════════════════════════════"
bash "$SCRIPT_DIR/scripts/install_packages_flatpak.sh"

# ── 4. Extra scripts ──────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════"
echo " [4/8] Running extra scripts"
echo "════════════════════════════════════"
bash "$SCRIPT_DIR/scripts/nvidia-fix.sh"
bash "$SCRIPT_DIR/scripts/install_mongodb_compass_1_44.7.sh"

# ── 5. Wallpapers ─────────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════"
echo " [5/8] Copying wallpapers"
echo "════════════════════════════════════"
mkdir -p ~/Pictures
cp -r "$SCRIPT_DIR/Wallpapers" ~/Pictures/
echo "Wallpapers copied to ~/Pictures"

# ── 6. Fonts ──────────────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════"
echo " [6/8] Copying fonts"
echo "════════════════════════════════════"
mkdir -p ~/.local/share/fonts
cp -r "$SCRIPT_DIR/fonts/." ~/.local/share/fonts/
fc-cache -f ~/.local/share/fonts
echo "Fonts copied to ~/.local/share/fonts"

# ── 7. pnpm ───────────────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════"
echo " [7/8] Installing pnpm"
echo "════════════════════════════════════"
curl -fsSL https://get.pnpm.io/install.sh | sh -
echo "pnpm installed"

# ── 8. GNU Stow ───────────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════"
echo " [8/8] Applying GNU Stow"
echo "════════════════════════════════════"
mkdir -p ~/.config
stow -d "$SCRIPT_DIR" -t ~/.config config
echo "Stow applied: config → ~/.config"

echo ""
echo "════════════════════════════════════"
echo " All done!"
echo "════════════════════════════════════"