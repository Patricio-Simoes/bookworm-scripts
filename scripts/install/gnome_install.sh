#!/usr/bin/env bash

#? This script automates the instalation process of a minimal gnome on Debian 12.

#! If Wayland session is missing when using the proprietary nvidia drivers, use:
#! ln -s /dev/null /etc/udev/rules.d/61-gdm.rules

source ./scripts/install/common.sh

#? Gnome itself.

sudo apt install gnome-session -y

#? Terminal.

sudo apt install gnome-terminal -y

#? File manager.

sudo apt install nautilus -y

#? PDFs.

sudo apt install evince pdfarranger -y

#? Multimedia.

sudo apt install eog totem gnome-music -y

#? Extensions.

sudo apt install gnome-shell-extension-manager -y

#? Others.

sudo apt install fonts-font-awesome galculator gnome-disk-utility gnome-tweaks -y

#? Common packages across DE's & WM's.

read_packages "$HOME/Documentos/bookworm-scripts/scripts/packages/base.txt"

install_packages "${packages[@]}"

#? Removes the unwanted apps.

sudo apt remove --purge evolution-data-server gnome-music gnome-online-accounts gnome-remote-desktop gnome-sushi totem -y

sudo apt autoremove -y
