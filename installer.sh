#!/bin/bash

apt update
apt install -y git

echo "Usage installer.sh USER PWD PUBLIC_IP"
echo "Clone repo"
git clone https://github.com/gbrian/codx-neko-rooms.git
cd codx-neko-rooms

echo "Install docker"
bash academy-hub/codx-room/apps/docker.sh

USER=$1
PWD=$2
IP=$(echo $(ifconfig | grep broadcast | tr " " "\n" | grep ^[0-9]) | awk '{print $1}')

echo "Install neko-rooms $USER $PWD $IP"
bash install.sh $USER $PWD $IP
