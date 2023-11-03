#!/bin/bash

curl -sL https://raw.githubusercontent.com/gbrian/codx-cli/main/codx.sh | bash -s
source ~/.bashrc

# Install APPS
if [ ! -z "$INSTALL_APPS" ]; then
  echo "**** INSTALL_APPS ****"
  bash -c "/yointly/install-apps.sh"
fi

if [ ! -z "$INIT_SCRIPT" ]; then
  echo "**** INIT SCRIPT ****"
  bash -c "$INIT_SCRIPT" &
fi

if [ ! -z "$READY_URL" ]; then
  echo "**** NOTIFY READY ****"
  curl "$READY_URL?host=$HOSTNAME" > /dev/null
fi

# run neko
/usr/bin/supervisord -c "/etc/neko/supervisord.conf"