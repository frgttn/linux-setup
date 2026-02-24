#!/bin/bash

echo "Checking for NVIDIA hardware..."
if ! lspci | grep -qi "nvidia"; then
  echo "Error: No NVIDIA hardware detected."
  exit 1
fi
echo "NVIDIA hardware found."

echo "Checking for nvidia-smi utility..."
if ! command -v nvidia-smi &>/dev/null; then
  echo "Error: nvidia-smi not found. Please install the NVIDIA drivers first."
  exit 1
fi
echo "nvidia-smi found: $(command -v nvidia-smi)"

echo "1. Creating systemd service for NVIDIA micro-stutter fix..."

# Write the configuration to the service file
cat << 'EOF' | sudo tee /etc/systemd/system/nvidia-min-clock.service > /dev/null
[Unit]
Description=NVIDIA GPU Minimum Clock Lock (Fix for UI stutter)
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/usr/bin/nvidia-smi -lgc 1770,2505
ExecStart=/usr/bin/nvidia-smi --lock-memory-clocks=8501,8501
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
