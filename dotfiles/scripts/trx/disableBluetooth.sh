#!/bin/bash

# Disable Bluetooth
rfkill block bluetooth

# Stop the Bluetooth service
sudo systemctl stop bluetooth

# Optionally, disable the Bluetooth service to prevent it from starting at boot
sudo systemctl disable bluetooth

echo "Bluetooth disabled and service stopped."
