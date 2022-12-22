#!/bin/bash

apt update
apt install -y git

echo "Usage installer.sh USER PWD PUBLIC_IP"
echo "Clone repo"
git clone https://github.com/gbrian/codx-neko-rooms.git
cd codx-neko-rooms
# Populate neko-rooms
git submodule init neko-rooms
git submodule update neko-rooms

echo "Install docker"
bash academy-hub/codx-room/apps/docker.sh

echo "Install neko-rooms $@"
bash install.sh $@
