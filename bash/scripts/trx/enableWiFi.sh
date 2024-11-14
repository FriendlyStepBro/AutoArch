#!/bin/bash

sudo systemctl enable iwd

sudo systemctl start iwd

echo "WiFi enabled and iwd daemon started."
