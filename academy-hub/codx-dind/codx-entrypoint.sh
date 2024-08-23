#!/bin/sh
echo "Running codx-entrypoint. Check docker engine"
until docker ps
do
  echo "waiting for docker..."
  sleep 1
done

echo "DOCKER READY $(docker-compose --version)"

echo "Allow internal"
chmod 666 /var/run/docker.sock

echo "Unpack images"
for image in /docker-images/*; do
  docker image load < $image
done

echo "Run compose"
docker-compose -p codx -f docker-compose.yaml up -d
