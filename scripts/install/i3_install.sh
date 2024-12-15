#!/usr/bin/env bash

BOOKWORM_SCRIPTS=$1

source $BOOKWORM_SCRIPTS/scripts/install/common.sh

packages=(
	"i3"
	"i3blocks"
	"upower"
)

# Read common packages from file.

read_packages "$BOOKWORM_SCRIPTS/scripts/packages/base_x11.txt"
read_packages "$BOOKWORM_SCRIPTS/scripts/packages/base_wm.txt"
read_packages "$BOOKWORM_SCRIPTS/scripts/packages/base.txt"

install_packages "${packages[@]}"
