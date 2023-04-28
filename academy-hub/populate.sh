source ./env.sh
echo "Pushing images"

function build_image {
    cd $1
    IMAGE_NAME=${PWD##*/}
    echo "Building image $IMAGE_NAME"
    TAG="${ACADEMY_HUB_DOMAIN}/codx/${IMAGE_NAME}:latest"
    docker build -t $TAG .
    docker push $TAG
}

if [ "$ACADEMY_HUB_USER" ]; then
  docker login -u $ACADEMY_HUB_USER -p $ACADEMY_HUB_PASSWORD ${ACADEMY_HUB_URL}
fi

BASE_DIR=$PWD
for d in */ ; do
    build_image $d || true
    cd $BASE_DIR
done