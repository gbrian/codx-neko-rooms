#!/bin/sh
# Run codx entrypoint as codx user
su -s sh codx /codx-entrypoint.sh &

echo "Running DIND entry-point"
/usr/local/bin/dockerd-entrypoint.sh