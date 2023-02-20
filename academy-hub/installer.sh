#!/bin/bash

apt update
apt install -y git

echo "Usage installer.sh USER PWD"
echo "Clone repo"
# clean repo
rm -rf github/gbrian/codx-neko-rooms
mkdir -p github/gbrian
# clone repo
git clone https://github.com/gbrian/codx-neko-rooms.git
cd codx-neko-rooms/academy-hub

echo "Install docker"
curl -sL https://raw.githubusercontent.com/gbrian/codx-cli/main/docker.sh | bash

bash setup-academy.sh