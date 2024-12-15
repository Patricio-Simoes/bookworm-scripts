#!/usr/bin/env bash

source ./scripts/install/common.sh

packages=(
	"i3"
	"i3blocks"
	"upower"
)

# Read common packages from file.

read_packages "$HOME/Documentos/bookworm-scripts/scripts/packages/base_x11.txt"
read_packages "$HOME/Documentos/bookworm-scripts/scripts/packages/base_wm.txt"
read_packages "$HOME/Documentos/bookworm-scripts/scripts/packages/base.txt"

install_packages "${packages[@]}"
