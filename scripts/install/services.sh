#!/usr/bin/env bash

# Contrib & non-free repositories.

sudo apt install software-properties-common -y
sudo add-apt-repository contrib non-free non-free-firmware
sudo apt update

# Bluetooth.

sudo apt install blueman bluez -y

# TLP.

sudo tlp start

# UFW.

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable

# Starship CLI.

curl -sS https://starship.rs/install.sh | sh
	
# Other packages/services.

echo "Install proprietary nvidia drivers? [Y/N]: "
read -r nvidia

if [ "$nvidia" = "Y" ] || [ "$nvidia" = "y" ]; then
	sudo apt install -y linux-headers-amd64 linux-image-amd64 nvidia-driver
fi

echo "Install pipewrire? [Y/N]: "
read -r pipewire

if [ "$pipewire" = "Y" ] || [ "$pipewire" = "y" ]; then
	sudo apt install -y pipewire pipewire-pulse pipewire-alsa libspa-0.2-bluetooth
	systemctl --user --now enable wireplumber.service
fi

echo "Install virt-manager? [Y/N]: "
read -r virtmanager

if [ "$virtmanager" = "Y" ] || [ "$virtmanager" = "y" ]; then
	sudo apt install -y qemu-kvm qemu-guest-agent libvirt-daemon libvirt-clients bridge-utils virt-manager

	sudo systemctl enable --now libvirtd
	
	sudo virsh net-start default
	sudo virsh net-autostart default

	sudo usermod -aG libvirt $USER
	sudo usermod -aG libvirt-qemu $USER
	sudo usermod -aG kvm $USER
	sudo usermod -aG input $USER
	sudo usermod -aG disk $USER
fi

echo "Install Mullvad VPN? [Y/N]: "
read -r mullvadvpn

if [ "$mullvadvpn" = "Y" ] || [ "$mullvadvpn" = "y" ]; then
	sudo curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc
	echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/mullvad.list
	sudo apt update
	sudo apt install mullvad-vpn -y
fi

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
