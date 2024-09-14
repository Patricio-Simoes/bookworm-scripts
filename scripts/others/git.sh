#!/usr/bin/env bash

# When using multiple SSH keys, you need to configure the ~/.ssh/config file.
# Example:
#   Host gitlab.com
#      PreferredAuthentications publickey
#      IdentityFile ~/.ssh/gitlab

clear

sleep 2

echo "#########################################################################################"
echo "# This script sets up git & creates an SSH key, saving it in a location of your choice. #"
echo "#           By default, SSH keys should be stored in the ~/.ssh/ directory.             #"
echo "#########################################################################################"
echo "\n"

echo -n "Enter the host, (ex: gitlab.com): "
read -r host

echo -n "Enter your username: "
read -r username

echo -n "Enter your e-mail address: "
read -r email

echo -n "Enter the path to store the key: ~/.ssh/"
read -r dir

path="/home/$USER/.ssh/$dir"

###################
# Setting up git. #
###################

git config --global user.name $username
git config --global user.email $email

git config --global color.ui auto

git config --global pull.rebase false

git config --global init.defaultBranch main

######################
# Generating SSH key #
######################

ssh-keygen -t ed25519 -C $email -f $path

cat $path.pub

###########################
# Filling the config file #
###########################

touch ~/.ssh/config
chmod 600 ~/.ssh/config
echo "Host $host" >> ~/.ssh/config
echo "	PreferredAuthentications publickey" >> ~/.ssh/config
echo "	IdentityFile ~/.ssh/$dir" >> ~/.ssh/config
