#!/usr/bin/env bash

#? This script goes through a list of flatpak packages and installs the one the user selects.

sudo apt install flatpak -y

#? Flathub Repository.

flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

#? Standalone packages.

echo -n "Install Cryptomator? [Y/N]: "
read -r input

if [ "$input" = "Y" ] || [ "$input" = "y" ]; then
	input=""
	packages="$packages org.cryptomator.Cryptomator"
fi

echo -n "Install Firefox? [Y/N]: "
read -r input

if [ "$input" = "Y" ] || [ "$input" = "y" ]; then
	input=""
	packages="$packages org.mozilla.firefox"
fi

echo -n "Install Flatseal? [Y/N]: "
read -r input

if [ "$input" = "Y" ] || [ "$input" = "y" ]; then
	input=""
	packages="$packages com.github.tchx84.Flatseal"
fi

echo -n "Install Freetube? [Y/N]: "
read -r input

if [ "$input" = "Y" ] || [ "$input" = "y" ]; then
	input=""
	packages="$packages io.freetubeapp.FreeTube"
fi

echo -n "Install Gimp? [Y/N]: "
read -r input

if [ "$input" = "Y" ] || [ "$input" = "y" ]; then
	input=""
	packages="$packages org.gimp.GIMP"
fi

echo -n "Install LibreOffice? [Y/N]: "
read -r input

if [ "$input" = "Y" ] || [ "$input" = "y" ]; then
	input=""
	packages="$packages org.libreoffice.LibreOffice"
fi

echo -n "Install Lutris? [Y/N]: "
read -r input

if [ "$input" = "Y" ] || [ "$input" = "y" ]; then
	input=""
	packages="$packages net.lutris.Lutris"
fi

echo -n "Install Obsidian? [Y/N]: "
read -r input

if [ "$input" = "Y" ] || [ "$input" = "y" ]; then
	input=""
	packages="$packages flathub md.obsidian.Obsidian"
fi

echo -n "Install OnlyOffice? [Y/N]: "
read -r input

if [ "$input" = "Y" ] || [ "$input" = "y" ]; then
	input=""
	packages="$packages flathub org.onlyoffice.desktopeditors"
fi

echo -n "Install Steam? [Y/N]: "
read -r input

if [ "$input" = "Y" ] || [ "$input" = "y" ]; then
	input=""
	packages="$packages com.valvesoftware.Steam"
fi

echo -n "Install Thunderbird? [Y/N]: "
read -r input

if [ "$input" = "Y" ] || [ "$input" = "y" ]; then
	input=""
	packages="$packages org.mozilla.Thunderbird"
fi

echo -n "Install VLC? [Y/N]: "
read -r input

if [ "$input" = "Y" ] || [ "$input" = "y" ]; then
	input=""
	packages="$packages org.videolan.VLC"
fi

flatpak install --user flathub $packages
