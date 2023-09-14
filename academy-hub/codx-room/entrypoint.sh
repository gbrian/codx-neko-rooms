#!/bin/bash
git clone https://github.com/gbrian/codx-cli.git
mv codx-cli ${CODX_HOME}/apps
chmod +x $CODX_APPS/codx.sh
RUN cp $CODX_APPS/codx.sh /bin/codx

# Check if we have to install extra tools
codx init
# Run supervisor
/usr/bin/supervisord -c /etc/neko/supervisord.conf