#!/bin/sh

until docker ps
do
  echo "waiting for docker..."
  sleep 1
done

echo "DOCKER READY $(docker-compose --version)"

echo "Allow internal"
chmod 666 /var/run/docker.sock

echo "Run compose"
docker-compose -f docker-compose.yaml up -d
