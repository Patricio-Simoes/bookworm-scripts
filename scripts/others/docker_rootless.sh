#!/usr/bin/env bash

sudo apt update

sudo apt install -y uidmap slirp4netns fuse-overlayfs iptables

curl -fsSL https://get.docker.com/rootless | sh

export PATH=/home/$USER/bin:$PATH

export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

source ~/.bashrc

systemctl --user start docker.service

systemctl --user enable docker.service

sudo usermod -aG docker $USER
