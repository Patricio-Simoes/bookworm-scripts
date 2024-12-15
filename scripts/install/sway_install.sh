#!/usr/bin/env bash

BOOKWORM_SCRIPTS=$1

source $BOOKWORM_SCRIPTS/scripts/install/common.sh

packages=(
	"sway"
	"swaylock"
)

# Read common packages from file.

read_packages "$BOOKWORM_SCRIPTS/scripts/packages/base_wayland.txt"
read_packages "$BOOKWORM_SCRIPTS/scripts/packages/base_wm.txt"
read_packages "$BOOKWORM_SCRIPTS/scripts/packages/base.txt"

install_packages "${packages[@]}"

sudo apt remove --purge policykit-1-gnome -y
