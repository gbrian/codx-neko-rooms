source ../.env 

docker pull alpine

docker build -t test:latest -f Dockerfile.test .

TAG="$ACADEMY_HUB_DOMAIN/codx/test:latest"
docker tag test:latest $TAG

docker login -u $ACADEMY_HUB_USER -p $ACADEMY_HUB_PASSWORD https://${ACADEMY_HUB_DOMAIN}
docker push $TAG
docker pull $TAG