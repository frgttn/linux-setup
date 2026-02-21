#!/bin/bash

# Define variables for convenience
URL="https://github.com/mongodb-js/compass/releases/download/v1.44.7/mongodb-compass-1.44.7-linux-x64.tar.gz"
TEMP_DIR="/tmp/compass_install"
ARCHIVE_NAME="compass.tar.gz"
EXTRACTED_FOLDER="MongoDB Compass-linux-x64"
INSTALL_DIR="/opt/mongodb-compass"
DESKTOP_FILE="/usr/share/applications/mongodb-compass.desktop"

echo "--- Starting MongoDB Compass Installation ---"

# 1. Create a temporary directory and navigate into it
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR" || exit

# 2. Download the archive (using wget for a nice progress bar)
echo "Downloading the archive..."
wget -q --show-progress "$URL" -O "$ARCHIVE_NAME"

# 3. Extract the archive
echo "Extracting files..."
tar -xzf "$ARCHIVE_NAME"

# 4. Move to /opt
echo "Installing to $INSTALL_DIR..."
# If the target directory already exists, remove it for a clean installation
if [ -d "$INSTALL_DIR" ]; then
    sudo rm -rf "$INSTALL_DIR"
fi
# Move the extracted folder and rename it to our target path
sudo mv "$EXTRACTED_FOLDER" "$INSTALL_DIR"

# 5. Download Icon and Create the .desktop shortcut file
echo "Downloading application icon..."
sudo wget -qO "$INSTALL_DIR/compass-icon.png" "https://raw.githubusercontent.com/mongodb-js/compass/refs/heads/main/packages/compass/app-icons/linux/mongodb-compass-logo-stable.png"

echo "Creating desktop shortcut..."
sudo bash -c "cat > $DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=MongoDB Compass
Comment=The GUI for MongoDB
Exec="$INSTALL_DIR/MongoDB Compass" %U
Icon=$INSTALL_DIR/compass-icon.png
Terminal=false
Type=Application
Categories=Development;Database;
EOF

# 6. Set access permissions
echo "Setting permissions..."
sudo chmod +x "$INSTALL_DIR/MongoDB Compass"
sudo chmod 644 "$DESKTOP_FILE"
# Update the desktop database so the app appears in the system menu immediately
sudo update-desktop-database /usr/share/applications/ 2>/dev/null || true

# 7. Clean up temporary files
echo "Cleaning up temporary files..."
cd /tmp || exit
rm -rf "$TEMP_DIR"

echo "--- Done! MongoDB Compass has been installed successfully. ---"
