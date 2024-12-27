#!/usr/bin/env bash

# This is a custom script, made in order to be able to change themes when pressing keyboard shortcuts.

# List of themes:

# 0 - Dracula theme.
# 1 - Everforest theme.
# 2 - Gruvbox theme.

NEW_THEME=$1

ALACRITTY_THEMES=("~/.config/alacritty/themes/dracula.toml" "~/.config/alacritty/themes/everforest.toml" "~/.config/alacritty/themes/gruvbox.toml")
BACKGROUNDS=("~/Imagens/Backgrounds/dracula-ship.png" "~/Imagens/Backgrounds/leafs.jpg" "~/Imagens/Backgrounds/samurai.jpg")
CONKY_THEMES=("/.config/conky/themes/dracula.conf" "/.config/conky/themes/everforest.conf" "/.config/conky/themes/gruvbox.conf")
GEANY_THEMES=("Dracula-Theme.conf" "Everforest-Theme.conf" "Gruvbox-Theme.conf")
GTK_THEMES=("dracula" "everforest" "gruvbox-dark")
ICON_THEMES=("dracula" "papirus-everforest" "papirus-gruvbox")
SWAY_THEMES=("~/.config/sway/themes/dracula" "~/.config/sway/themes/everforest" "~/.config/sway/themes/gruvbox")
WAYBAR_THEMES=("./colorschemes/dracula.css" "./colorschemes/everforest.css" "./colorschemes/gruvbox.css")
WOFI_THEMES=(".config/wofi/themes/dracula.css" ".config/wofi/themes/everforest.css" ".config/wofi/themes/gruvbox.css")

# Alacritty.
sed -i "2s|.*|  - ${ALACRITTY_THEMES[$NEW_THEME]}|" $HOME/.config/alacritty/alacritty.yml
# Background.
sed -i "8s|.*|set \$wallpaper ${BACKGROUNDS[$NEW_THEME]}|" $HOME/.config/sway/config.d/monitors
# Conky.
sed -i "3s|.*|local config_path = home .. '${CONKY_THEMES[$NEW_THEME]}'|" $HOME/.config/conky/wayland/config_amd.conf
$HOME/.config/conky/start.sh
# Flatpak theme.
flatpak override --user --env=GTK_THEME="${GTK_THEMES[$NEW_THEME]}"
flatpak override --user --env=ICON_THEME="${ICON_THEMES[$NEW_THEME]}"
# Geany.
sed -i "23s|.*|color_scheme="${GEANY_THEMES[$NEW_THEME]}"|" $HOME/.config/geany/geany.conf
# GTK theme.
gsettings set org.gnome.desktop.interface gtk-theme "${GTK_THEMES[$NEW_THEME]}"
sed -i "1s|.*|gtk-theme-name=\""${GTK_THEMES[$NEW_THEME]}"\"|" $HOME/.config/gtk-2.0/settings.ini
sed -i "2s|.*|gtk-theme-name="${GTK_THEMES[$NEW_THEME]}"|" $HOME/.config/gtk-3.0/settings.ini
sed -i "2s|.*|gtk-theme-name="${GTK_THEMES[$NEW_THEME]}"|" $HOME/.config/gtk-4.0/settings.ini
# Icon theme.
gsettings set org.gnome.desktop.interface icon-theme "${ICON_THEMES[$NEW_THEME]}"
sed -i "2s|.*|gtk-icon-theme-name=\""${ICON_THEMES[$NEW_THEME]}"\"|" $HOME/.config/gtk-2.0/settings.ini
sed -i "3s|.*|gtk-icon-theme-name="${ICON_THEMES[$NEW_THEME]}"|" $HOME/.config/gtk-3.0/settings.ini
sed -i "3s|.*|gtk-icon-theme-name="${ICON_THEMES[$NEW_THEME]}"|" $HOME/.config/gtk-4.0/settings.ini
# Sway.
sed -i "32s|.*|include ${SWAY_THEMES[$NEW_THEME]}|" $HOME/.config/sway/config
# Swaylock.
sed -i "1s|.*|image=${BACKGROUNDS[$NEW_THEME]}|" $HOME/.config/swaylock/config
# Waybar.
sed -i "1s|.*|@import \"${WAYBAR_THEMES[$NEW_THEME]}\";|" $HOME/.config/waybar/style.css
# Wofi.
sed -i "1s|.*|@import url(\"${WOFI_THEMES[$NEW_THEME]}\");|" $HOME/.config/wofi/style.css

# Geany.

swaymsg reload
