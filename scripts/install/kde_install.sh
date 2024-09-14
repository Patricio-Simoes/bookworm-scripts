#!/usr/bin/env bash

#? This script automates the instalation process of a minimal KDE on Debian 12.

#? Plasma minimal.

sudo apt install kde-plasma-desktop plasma-nm -y

#? Multimedia.

sudo apt install dragonplayer elisa gwenview okular -y

#? Extract tools.

sudo apt install ark -y

#? Others.

sudo apt install kcalc -y

#? Unwanted packages.

sudo apt remove --purge kamera kdeconnect khelpcenter konqueror kwrite plasma-vault -y

sudo apt autoremove -y
