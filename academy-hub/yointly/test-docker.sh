
docker build -t codx/yointly:latest .
docker run --rm -it \
  -e HOSTNAME=${HOSTNAME} \
  -e SYNC_DATA=1 \
  -v $PWD/scripts:/yointly \
  -v $PWD/supervisord.conf:/etc/neko/supervisord/firefox.conf \
  codx/yointly:latest bash