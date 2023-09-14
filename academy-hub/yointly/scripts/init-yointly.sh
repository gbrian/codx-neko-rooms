#!/bin/bash

curl -sL https://raw.githubusercontent.com/gbrian/codx-cli/main/codx.sh > /yointly/codx.sh
bash /yointly/codx.sh
  
# Install APPS
if [ ! -z "$INSTALL_APPS" ]; then
  echo "**** INSTALL_APPS ****"
  source ~/.bashrc
  bash /yointly/install-apps.sh
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