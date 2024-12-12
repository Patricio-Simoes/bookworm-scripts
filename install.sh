#!/usr/bin/env bash

echo "###################################################################################################################"
echo "#          Welcome! These are my personal scripts that facilitate the instalation process of Debian 12.           #"
echo "#       Here, you can select a variety of packages to install on your system, starting from a server base.        #"
echo "# This helps creating a minimal install with minimal package count, preventing unwanted packages and saving time. #"
echo "#           I hope you find these scripts helpful and if you have any suggestions, please let me know.            #"
echo "#                                          Cheers! - Patrício Simões                                              #"
echo "###################################################################################################################"

sleep 5

flag=false

input=""

chmod 700 ./scripts/install/*
chmod 700 ./scripts/others/*
chmod 700 ./scripts/packages/*

while [ "$flag" = false ]; do

    echo ""
    echo "###################################"
    echo "# What would you like to install? #"
    echo "###################################"
    echo "Desktop Environments"
    echo "  1. Gnome"
    echo "  2. KDE"
    echo "Window Managers"
    echo "  3. i3"
    echo "  4. sway"
    echo -n "Your choice: "
    read -r input

    echo -n "You have selected option $input, is this correct? [Y/N]: "
    read -r confirm
    
    if [ "$confirm" = "Y" ] || [ "$confirm" = "y" ]; then
        flag=true
        confirm=false
    fi
done

if [ "$input" = "1" ]; then
    ./scripts/install/gnome_install.sh
elif [ "$input" = "2" ]; then
    ./scripts/install/kde_install.sh
elif [ "$input" = "3" ]; then
    ./scripts/install/i3_install.sh
elif [ "$input" = "4" ]; then
    ./scripts/install/sway_install.sh
fi

if which thunar > /dev/null 2>&1; then
    xdg-mime default thunar.desktop inode/directory
fi

input=""

#? Installs some useful packages.

echo -n "Would you like to run the services.sh script? [Y/N]: "
read -r confirm

if [ "$confirm" = "Y" ] || [ "$confirm" = "y" ]; then
	./scripts/install/services.sh
fi

clear

echo -n "Would you like to go through the flatpak.sh script? [Y/N]: "
read -r flatpak

if [ "$flatpak" = "Y" ] || [ "$flatpak" = "y" ]; then
	./scripts/install/flatpak.sh
fi

printf "\e[1;32mWe're done here, have fun with your system!\e[0m\n"
