#!/usr/bin/env bash

#? This script automates the instalation process of a minimal gnome on Debian 12.

#! If Wayland session is missing when using the proprietary nvidia drivers, use:
#! ln -s /dev/null /etc/udev/rules.d/61-gdm.rules

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

sudo apt install gnome-shell-extension-manager gnome-tweaks -y

#? Others.

sudo apt install galculator gnome-disk-utility -y

#? Removes the help app.

sudo apt remove --purge yelp -y

sudo apt autoremove -y
