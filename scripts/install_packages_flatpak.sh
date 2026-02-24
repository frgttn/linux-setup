#!/bin/bash

set -e

# ── Flatpak ────────────────────────────────────────────────────────────────────
echo "==> Installing packages from flatpak..."
flatpak install -y flathub \
	md.obsidian.Obsidian \
	com.bitwarden.desktop \
	org.telegram.desktop \
	org.libreoffice.LibreOffice \
	com.discordapp.Discord \
	org.filezillaproject.Filezilla \
	it.mijorus.gearlever \
	com.google.Chrome \
	org.kde.krita \
	org.qbittorrent.qBittorrent \
	com.redis.RedisInsight \
	app.zen_browser.zen