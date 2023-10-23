DIR=$PWD
echo "[PREBUILD] building dependencies"
cd .. && bash ./populate.sh "codx-dind,codx-openfortivpn,codx-room"
if [ ! -d $DIR/images ];then
  echo "[PREBUILD] Copying images"
  mkdir $DIR/images
  docker image save academy-hub.meetnav.com/codx/codx-openfortivpn:latest > $DIR/images/codx-openfortivpn.tar
  docker image save academy-hub.meetnav.com/codx/codx-room:latest > $DIR/images/codx-room.tar
fi