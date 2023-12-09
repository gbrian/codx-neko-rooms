#!/bin/bash
set -x
curl -sL https://raw.githubusercontent.com/gbrian/codx-cli/main/codx.sh | bash -s
. ~/.bashrc
echo "***********************************************"
echo "***                                         ***"
echo "*** CODX                                    ***"
echo "***                                         ***"
echo "***********************************************"
# Install APPS
if [ ! -z "$INSTALL_APPS" ]; then
echo "***********************************************"
echo "***                                         ***"
echo "*** APPS                                    ***"
echo "***                                         ***"
echo "***********************************************"
  bash "/yointly/install-apps.sh"
fi

if [ ! -z "$INIT_SCRIPT" ]; then
echo "***********************************************"
echo "***                                         ***"
echo "*** INIT SCRIP                              ***"
echo "***                                         ***"
echo "***********************************************"
  echo $INIT_SCRIPT > ~/_init_script.sh
  bash ~/_init_script.sh &
fi

if [ ! -z "$READY_URL" ]; then
  echo "**** NOTIFY READY ****"
  curl "$READY_URL?host=$HOSTNAME" > /dev/null
fi
# Set ready flag
echo "done!" > /var/www/ready.html

echo "***********************************************"
echo "***                                         ***"
echo "*** DONE                                    ***"
echo "***                                         ***"
echo "***********************************************"

# run neko
echo "*** Starting /usr/bin/supervisord"
/usr/bin/supervisord -c "/etc/neko/supervisord.conf"