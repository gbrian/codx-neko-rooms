#!/bin/bash

apt update
apt install -y git

echo "Usage installer.sh USER PWD [PUBLIC_IP]"
echo "Clone repo"
mkdir -p /root/github/gbrian
cd /root/github/gbrian
git clone https://github.com/gbrian/codx-neko-rooms.git
cd codx-neko-rooms
# Populate neko-rooms
git submodule update --init neko-rooms

echo "Install docker"
bash academy-hub/codx-room/apps/docker.sh

echo "Data folder"
mkdir -p /root/codx-neko-rooms/data

echo "Install neko-rooms $@"
bash install.sh $@

# TODO:....
echo "Register provider"
#curl -X POST https://api-codx.meetnav.com/api/cloud-providers/register-neko-rooms \
#   -H 'Content-Type: application/json' \
#   -d '{"ip":"my_login","user":"admin","pwd":"my_password","token":"TOOOKKKEENNN"}'