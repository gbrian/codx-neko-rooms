#!/bin/bash

if [ "$VPN_HOST" ]; then
    echo "Trying to connect VPN"
    /connect.sh
fi

# Go sleep
while true; do
    sleep 5
done