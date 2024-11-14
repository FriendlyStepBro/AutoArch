#!/bin/bash

# Enable Bluetooth
rfkill unblock bluetooth

# Start the Bluetooth service
sudo systemctl start bluetooth

# Optionally, enable the Bluetooth service to start it at boot
sudo systemctl enable bluetooth

echo "Bluetooth enabled and service started."
