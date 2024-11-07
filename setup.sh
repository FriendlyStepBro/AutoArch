#!/bin/bash

export installer_location=$(dirname $(realpath $0))
export user_name=$(whoami)

# Set time format to match windows to allow synchronisation for dual boot
sudo timedatectl set-local-rtc 1 #--adjust-system-clock

# Package install and organiser
# Saves AUR packages to a list to be installed after yay has been installed
aur_packages=()
while IFS= read -r package; do
	if pacman -Si "$package" &> /dev/null; then
		sudo pacman -S --noconfirm "$package"
	else
		aur_packages+=("$package")
	fi
done < packages

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
rm -rf yay

for package in "${aur_packages[@]}"; do
	yay -S --noconfirm "$package"
done

curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
sudo bash strap.sh
rm -rf strap.sh

sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/
sudo tee /etc/systemd/system/getty@tty1.service.d/override.conf > /dev/null << EOL
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin $user_name --noclear %I \$TERM
Type=simple
EOL

sudo systemctl daemon-reload
sudo systemctl enable getty@tty1.service

sudo auto-cpufreq --install

exit 1
