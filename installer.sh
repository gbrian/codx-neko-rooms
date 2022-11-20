#!/bin/bash
echo "Usage installer.sh USER PWD PUBLIC_IP"
echo "Clone repo"
git clone https://github.com/gbrian/neko-rooms.git

echo "Install docker"
cd neko-rooms
bash academy-hub/codx-room/apps/docker.sh

echo "Install neko-rooms"
bash install.sh $@
