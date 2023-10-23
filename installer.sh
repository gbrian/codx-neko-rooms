#!/bin/bash
apt update
apt install -y git

echo "Usage installer.sh USER PWD [PUBLIC_IP]"
echo "Clone repo"

# clean repo
rm -rf codx-neko-rooms

# clone repo
git clone https://github.com/gbrian/codx-neko-rooms.git
cd codx-neko-rooms
# Populate neko-rooms
git submodule update --init neko-rooms

# Point neko-rooms to codx-master
cd neko-rooms
git checkout codx-master
cd ..

echo "Install docker"
curl -sL https://raw.githubusercontent.com/gbrian/codx-cli/main/docker.sh | bash

echo "Data folder"
sudo mkdir /data

echo "Shared folder"
sudo mkdir /shared

echo "Install neko-rooms $@"
bash install.sh $@

echo "Save update"
echo "#!/bin/bash" > update.sh
echo "curl -sL https://raw.githubusercontent.com/gbrian/codx-neko-rooms/main/installer.sh | bash -s -- $@" >> update.sh
chmod +x update.sh

# TODO:....
# echo "Register provider"
#curl -X POST https://api-codx.meetnav.com/api/cloud-providers/register-neko-rooms \
#   -H 'Content-Type: application/json' \
#   -d '{"ip":"my_login","user":"admin","pwd":"my_password","token":"TOOOKKKEENNN"}'
