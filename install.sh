apt-get install -y apache2-utils


USER=$1
PASSWORD=$2
IP=$3

# Generate auth file
docker run \
  --entrypoint htpasswd \
  httpd:2 -Bbn $USER $PASSWORD > usersfile

# Generate API_TOKEN
export API_TOKEN=$(echo -nz "${USER}:${PASSWORD}" | md5sum | grep -o '^\S\+')

# ENV
export NEKO_ROOMS_NAT1TO1=$IP
export NEKO_ROOMS_EPR=59000-59300

export NEKO_ROOMS_NEKO_IMAGES="academy-hub.meetnav.com/* m1k1o/neko:firefox m1k1o/neko:chromium"
export NEKO_ROOMS_NEKO_PRIVILEGED_IMAGES="*dind"

export NEKO_ROOMS_DEBUG=true

export API_PROXY_CONF_ENDPOINT="https://api-codx.meetnav.com/api/neko-rooms/proxy?token=$API_TOKEN"

export NEKO_ROOMS_LOGS=true
export NEKO_ROOMS_TRAEFIK_NETWORK=neko-rooms-net
export NEKO_ROOMS_TRAEFIK_ENTRYPOINT=web

# Registry
export NEKO_ROOMS_REGISTRY_DOMAIN="academy-hub.meetnav.com"

echo "******* RUNNING SERVICES ********"
echo ""
echo " API_TOKEN: $API_TOKEN"
echo ""

# Run service
docker network create -d bridge neko-rooms-net || true
docker-compose up -d

