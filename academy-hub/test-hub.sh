source ../.env 

docker pull alpine

touch testFile
docker build -t test:latest -f Dockerfile.test .


TAG="$ACADEMY_HUB_DOMAIN/codx/test:latest"
echo "Tagging image as $TAG"
docker tag test:latest $TAG

echo "Login"
docker login -u $ACADEMY_HUB_USER -p $ACADEMY_HUB_PASSWORD https://${ACADEMY_HUB_DOMAIN}
echo "Push"
docker push $TAG
echo "Delete image and pull"
docker image rm $TAG
docker pull $TAG

echo "Clean"
docker image rm test:latest
rm testFile