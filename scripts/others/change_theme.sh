#!/usr/bin/env bash

# This is a custom script, made in order to be able to change themes when pressing keyboard shortcuts.

# List of themes:

# 0 - Dracula theme.
# 1 - Everforest theme.

NEW_THEME=$1

ALACRITTY_THEMES=("~/.config/alacritty/themes/dracula.toml" "~/.config/alacritty/themes/everforest.toml")
BACKGROUNDS=("~/Imagens/Backgrounds/dracula-ship.png" "~/Imagens/Backgrounds/leafs.jpg")
CONKY_THEMES=("/.config/conky/themes/dracula.conf" "/.config/conky/themes/everforest.conf")
GTK_THEMES=("dracula" "everforest")
ICON_THEMES=("dracula" "Papirus" "nordzy" "qogir")
SWAY_THEMES=("~/.config/sway/themes/dracula" "~/.config/sway/themes/everforest")
WAYBAR_THEMES=("./colorschemes/dracula.css" "./colorschemes/everforest.css")
WOFI_THEMES=(".config/wofi/themes/dracula.css" ".config/wofi/themes/everforest.css")

# Alacritty.
sed -i "2s|.*|  - ${ALACRITTY_THEMES[$NEW_THEME]}|" $HOME/.config/alacritty/alacritty.yml
# Background.
sed -i "7s|.*|set \$wallpaper ${BACKGROUNDS[$NEW_THEME]}|" $HOME/.config/sway/config.d/monitors
# Conky.
sed -i "3s|.*|local config_path = home .. '${CONKY_THEMES[$NEW_THEME]}'|" $HOME/.config/conky/wayland/config_amd.conf
$HOME/.config/conky/start.sh
# Flatpak theme.
flatpak override --user --env=GTK_THEME="${GTK_THEMES[$NEW_THEME]}"
flatpak override --user --env=ICON_THEME="${ICON_THEMES[$NEW_THEME]}"
# GTK theme.
gsettings set org.gnome.desktop.interface gtk-theme "${GTK_THEMES[$NEW_THEME]}"
# Icon theme.
gsettings set org.gnome.desktop.interface icon-theme "${ICON_THEMES[$NEW_THEME]}"
# Sway.
sed -i "31s|.*|include ${SWAY_THEMES[$NEW_THEME]}|" $HOME/.config/sway/config
# Swaylock.
sed -i "1s|.*|image=${BACKGROUNDS[$NEW_THEME]}|" $HOME/.config/swaylock/config
# Waybar.
sed -i "1s|.*|@import \"${WAYBAR_THEMES[$NEW_THEME]}\";|" $HOME/.config/waybar/style.css
# Wofi.
sed -i "1s|.*|@import url(\"${WOFI_THEMES[$NEW_THEME]}\");|" $HOME/.config/wofi/style.css

# Geany.

swaymsg reload
