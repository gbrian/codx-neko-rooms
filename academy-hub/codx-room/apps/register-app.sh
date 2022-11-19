APP_NAME=$1
APP_BIN=$2

sudo echo "
[program:${APP_NAME}]
environment=HOME=\"/home/codx\",USER=\"codx\"
directory=/home/codx
command=${APP_BIN}
user=codx
stopsignal=INT
autorestart=true
priority=800
redirect_stderr=true
" > /etc/neko/supervisord/${APP_NAME}.conf

sudo service supervisor restart