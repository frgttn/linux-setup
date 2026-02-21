#!/bin/bash

# Check if the script is run as root (via sudo)
if [ "$EUID" -ne 0 ]; then
  echo "Error: This script must be run as root."
  echo "Usage: sudo bash $0"
  exit 1
fi

echo "1. Creating systemd service for NVIDIA micro-stutter fix..."

# Write the configuration to the service file
cat << 'EOF' > /etc/systemd/system/nvidia-min-clock.service
[Unit]
Description=NVIDIA GPU Minimum Clock Lock (Fix for UI stutter)
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/usr/bin/nvidia-smi -lgc 400,3000
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

echo "2. Reloading systemd daemon..."
systemctl daemon-reload

echo "3. Enabling and starting the service..."
systemctl enable --now nvidia-min-clock.service

echo "=========================================="
echo "Done! The fix has been successfully applied."
echo "Current service status:"
systemctl status nvidia-min-clock.service --no-pager | grep "Active:"
