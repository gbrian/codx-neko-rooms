
USER=${1:admin}
PASSWORD=${2:admin}
AUTO_IP=$(echo $(ifconfig | grep "broadcast 0.0.0.0" | tr " " "\n" | grep ^[0-9]) | awk '{print $1}')
IP=${3:-${AUTO_IP}}

# Generate auth file
docker run --rm \
  --entrypoint htpasswd \
  httpd:2 -Bbn $USER $PASSWORD > usersfile

API_TOKEN=$(echo -nz ${USER}:${PASSWORD} | md5sum | grep -o '^\S\+')
echo " # Generate API_TOKEN
API_TOKEN=$API_TOKEN

# ENV

NEKO_ROOMS_NAT1TO1=$IP
NEKO_ROOMS_EPR=59000-59300

NEKO_ROOMS_NEKO_IMAGES='academy-hub.meetnav.com/* academy-hub.meetnav.com/codx/codx-room:latest m1k1o/neko:firefox m1k1o/neko:chromium'
NEKO_ROOMS_NEKO_PRIVILEGED_IMAGES=*dind

NEKO_ROOMS_DEBUG=true

API_PROXY_CONF_ENDPOINT=https://api-codx.meetnav.com/api/neko-rooms/proxy?token=$API_TOKEN

NEKO_ROOMS_LOGS=true
NEKO_ROOMS_TRAEFIK_NETWORK=neko-rooms-net
NEKO_ROOMS_TRAEFIK_ENTRYPOINT=web

# Registry
NEKO_ROOMS_REGISTRY_DOMAIN=academy-hub.meetnav.com

ACADEMY_HUB_DOMAIN=academy-hub.meetnav.com
ACADEMY_HUB_USER=$USER
ACADEMY_HUB_PASSWORD=$PASSWORD

REGISTRY_HTTP_SECRET=$API_TOKEN

" > .env

echo "******* RUNNING SERVICES ********"
echo ""
echo " API_TOKEN: $API_TOKEN"
echo ""

# Run service
docker network create -d bridge neko-rooms-net || true
docker-compose up -d
