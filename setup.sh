#!/bin/bash

if [ "$(id -u)" -eq 0 ]; then
	echo "Must be run as user, not root."
	exit 1
fi

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

for package in "${aur_packages[@]}"; do
	yay -S --noconfirm "$package"
done

curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
sudo bash strap.sh
rm -rf strap.sh

git clone https://github.com/m4thewz/dracula-icons ~/.icons/Dracula

sudo rm -f $HOME/.bashrc
sudo ln $HOME/repos/autoarch/bash/bashrc $HOME/.bashrc
source ~/.bashrc

# sudo systemctl enable getty@tty1.service
bash $HOME/repos/autoarch/script/dotfiles_link.sh
