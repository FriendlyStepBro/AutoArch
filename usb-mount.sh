#!/bin/bash
MOUNT_POINT="$HOME/disks"
DEVICE="/dev/$1"
LABEL=$(lsblk -no LABEL $DEVICE)
UUID=$(lsblk -no UUID $DEVICE)

# Fallback to UUID if no label
[ -z "$LABEL" ] && LABEL=$UUID

# Create mount point
mkdir -p "$MOUNT_POINT/$LABEL"

# Mount device
mount $DEVICE "$MOUNT_POINT/$LABEL" || logger "Failed to mount $DEVICE to $MOUNT_POINT/$LABEL"
