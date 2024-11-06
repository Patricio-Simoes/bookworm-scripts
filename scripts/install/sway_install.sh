#!/usr/bin/env bash

source ./common.sh

packages=(
	"sway"
	"swaylock"
)

# Read common packages from file.

read_packages "$HOME/Documentos/bookworm-scripts/scripts/packages/base_wayland.txt"
read_packages "$HOME/Documentos/bookworm-scripts/scripts/packages/base_wm.txt"
read_packages "$HOME/Documentos/bookworm-scripts/scripts/packages/base.txt"

install_packages "${packages[@]}"

sudo apt remove --purge policykit-1-gnome -y
