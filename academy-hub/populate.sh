source ./env.sh
echo "Pushing images"

function build_image {
    IMAGE_NAME=${PWD##*/}

    TAGARM="${ACADEMY_HUB_DOMAIN}/codx/${IMAGE_NAME}:arm"
    echo "Building image $TAGARM"
    DOCKER_BUILDKIT=1 docker build -f Dockerfile.arm -t ${TAGARM} --platform="linux/arm/v7" .
    docker push ${TAGARM}

    TAG="${ACADEMY_HUB_DOMAIN}/codx/${IMAGE_NAME}:latest"
    echo "Building image $TAG"
    docker build -t $TAG .
    docker push $TAG
}

if [ "$ACADEMY_HUB_USER" ]; then
  docker login -u $ACADEMY_HUB_USER -p $ACADEMY_HUB_PASSWORD ${ACADEMY_HUB_URL}
fi

BASE_DIR=$PWD
for d in "yointly" ; do
    cd $d
    build_image $d || true
    cd $BASE_DIR
    exit
done