#!/usr/bin/env bash

# Change DNS settings & make /etc/resolv.conf immutable.

dns_servers=("1.1.1.1" "1.0.0.1")

for server in "${dns_servers[@]}"; do
    echo "nameserver $server" | sudo tee -a /etc/resolv.conf > /dev/null
done

sudo chattr +i /etc/resolv.conf

# Contrib & non-free repositories.

sudo apt install software-properties-common -y
sudo add-apt-repository contrib non-free non-free-firmware
sudo apt update

# UFW.

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable

# Starship CLI.

curl -sS https://starship.rs/install.sh | sh
	
# Other packages/services.

echo -n "Install proprietary nvidia drivers? [Y/N]: "
read -r nvidia

if [ "$nvidia" = "Y" ] || [ "$nvidia" = "y" ]; then
	sudo apt install -y linux-headers-amd64 linux-image-amd64 nvidia-driver
fi

echo -n "Install pipewire? [Y/N]: "
read -r pipewire

if [ "$pipewire" = "Y" ] || [ "$pipewire" = "y" ]; then
	sudo apt install -y pipewire pipewire-pulse pipewire-alsa libspa-0.2-bluetooth
	systemctl --user --now enable wireplumber.service
fi

echo -n "Install distrobox? [Y/N]: "
read -r distrobox

if [ "$distrobox" = "Y" ] || [ "$distrobox" = "y" ]; then
	echo "Please select on of the following:"
	echo "1. Docker setup"
	echo "2. Rootless Docker setup"
	echo "3. Normal, (Podman), setup"
	echo "[Other Key]. Exit"
	echo -n ": "
	read -r distrobox
	if [ "$distrobox" = "1" ]; then
		../others/docker.sh
		curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh
	elif [ "$distrobox" = "2" ]; then
		../others/docker_rootless.sh
		curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh
	elif [ "$distrobox" = "3" ]; then
		sudo apt install distrobox -y
	fi
fi

echo -n "Install virt-manager? [Y/N]: "
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

echo -n "Install a VPN client? [Y/N]: "
read -r vpn

if [ "$vpn" = "Y" ] || [ "$vpn" = "y" ]; then
	echo "Please select on of the following:"
	echo "1. Mullvad VPN"
	echo "2. Proton VPN"
	echo "[Other Key]. Exit"
	echo -n ": "
	read -r distrobox
	if [ "$vpn" = "1" ]; then
		sudo curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc
		echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/mullvad.list
		sudo apt update
		sudo apt install mullvad-vpn -y
	elif [ "$vpn" = "2" ]; then
		wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.6_all.deb
		sudo dpkg -i ./protonvpn-stable-release_1.0.6_all.deb
		sudo apt update
		sudo apt install proton-vpn-gnome-desktop -y
		sudo apt install natpmpc
		apt policy natpmpc libnatpmp*
	fi
fi

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
