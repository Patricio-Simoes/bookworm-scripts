#!/usr/bin/env bash

# Install Starship CLI.

curl -sS https://starship.rs/install.sh | sh

# List of applications to install.

apps=("code")

# Update and install applications.

sudo pacman -Syu "${apps[@]}"

# Export applications.

for app in "${apps[@]}"; do
    distrobox-export --app "$app"
done

# Uncomment the line for pt_PT.UTF-8 in /etc/locale.gen.

if sudo sed -i 's/^\s*#\s*pt_PT\.UTF-8\s*UTF-8/pt_PT.UTF-8 UTF-8/' /etc/locale.gen; then
    echo "Successfully uncommented pt_PT.UTF-8 in /etc/locale.gen."
else
    echo "Failed to uncomment pt_PT.UTF-8."
    exit 1
fi

# Regenerate locales.

if sudo locale-gen; then
    echo "Locales regenerated successfully."
else
    echo "Failed to regenerate locales."
    exit 1
fi
