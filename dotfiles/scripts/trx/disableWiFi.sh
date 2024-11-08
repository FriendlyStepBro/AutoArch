#!/bin/bash

# Disable WiFi in iwctl
iwctl station wlan0 disconnect

# Stop the iwd daemon to prevent any further WiFi activity
sudo systemctl stop iwd

# Optionally, disable the iwd service to prevent it from starting at boot
sudo systemctl disable iwd

echo "WiFi disabled and iwd daemon stopped."
