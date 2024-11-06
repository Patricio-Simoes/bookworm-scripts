#!/usr/bin/env bash

# Function to read common packages from a file.

read_packages() {
    local base_file="$1"
    if [ -f "$base_file" ]; then
        export packages+=( $(< "$base_file") )
    else
        echo "File not found: $base_file"
        exit 1
    fi
}

# Function to install packages if they are not already installed.

install_packages() {
    local pkgs=("$@")
    local missing_pkgs=()

    # Check if each package is installed.
    for pkg in "${pkgs[@]}"; do
        if ! dpkg -l | grep -q " $pkg "; then
            missing_pkgs+=("$pkg")
        fi
    done

    # Install missing packages.
    if [ ${#missing_pkgs[@]} -gt 0 ]; then
        echo "Installing missing packages: ${missing_pkgs[@]}"
        sudo apt update
        sudo apt install -y "${missing_pkgs[@]}"
        if [ $? -ne 0 ]; then
            echo "Failed to install some packages. Exiting."
            exit 1
        fi
    else
        echo "All required packages are already installed."
    fi
}
