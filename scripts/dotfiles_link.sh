#!/bin/bash

[[ "$EUID" -ne 0 ]] && { echo "Must be run as root"; exit 1; }

user=$(whoami)
echo "Copying dotfiles to user: "$user""
