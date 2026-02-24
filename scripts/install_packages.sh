#!/bin/bash

set -e

# ── Pacman ────────────────────────────────────────────────────────────────────
echo "==> Updating system..."
sudo pacman -Syu --noconfirm

echo "==> Installing packages from pacman..."
sudo pacman -S --noconfirm \
	alacritty \
	btop \
	chromium \
	firefox \
	fish \
	flatpak \
	fuse2 \
	nvtop \
	opencode \
	starship \
	stow \
	tmux \
	tesseract \
	tesseract-data-eng \
	tesseract-data-rus \
	tesseract-data-ukr \
	zed

# ── AUR (paru) ────────────────────────────────────────────────────────────────
if ! command -v paru &>/dev/null; then
    echo "==> paru not found — installing paru..."
    sudo pacman -S --noconfirm --needed base-devel git
    tmpdir=$(mktemp -d)
    git clone https://aur.archlinux.org/paru.git "$tmpdir/paru"
    pushd "$tmpdir/paru" > /dev/null
    makepkg -si --noconfirm
    popd > /dev/null
    rm -rf "$tmpdir"
fi

echo "==> Installing packages from AUR..."
paru -S --noconfirm \
    microsoft-edge-stable-bin \
    visual-studio-code-bin
