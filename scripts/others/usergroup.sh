#!/usr/bin/env bash

# This script creates a new group, assigns the current user to it, and makes it so that 
# the users in that group can run a specific program that would normally require sudo priviledges without them.

# Example usage:
# ./ usergroup.sh veracryptusers /usr/bin/veracrypt

sudo groupadd $1

sudo usermod -a -G $1 $USER

sudo touch /etc/sudoers.d/$(basename $2)

echo "%$1 ALL=(root) NOPASSWD:$2" | sudo tee -a /etc/sudoers.d/$(basename $2) > /dev/null

sudo chmod 0440 /etc/sudoers.d/$(basename $2)
