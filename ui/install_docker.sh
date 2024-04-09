#!/bin/bash

echo "Remove old Docker-Version..."
#for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

echo "Install new Docker-Version..."
curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh ./get-docker.sh

echo "Add User $USER to the Docker group"

sudo usermod -aG docker "$USER"

echo "Please Reboot"