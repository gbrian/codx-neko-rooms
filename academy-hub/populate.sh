set -e

source ./env.sh
echo "Pushing images"

function build_image {
    IMAGE_NAME=${PWD##*/}
    PREBUILD_FILE="$PWD/pre-build.sh"
    TEST_FILE="$PWD/test.sh"

    echo "****** BYUILDING $IMAGE_NAME"

    if test -f $PREBUILD_FILE; then
      echo "****** PREBUILD SCRIPT"
      bash $PREBUILD_FILE
    fi

    for dockerfile in ./Dockerfile*
    do
      IFS='.' read -ra PARTS <<< $dockerfile
      echo "PARTS ${PARTS[@]} TAG ${PARTS[2]}"
      TAG="${ACADEMY_HUB_DOMAIN}/codx/${IMAGE_NAME}:${PARTS[2]:-latest}"
      echo "Building image $TAG"
      docker build -f $dockerfile -t $TAG $@ .
      if [ $? != 0 ]; then
        echo "Building image $TAG FAILED!!"
        exit $?
      fi
      if test -f $TEST_FILE; then
        echo "****** TESTING IMAGE"
        bash $TEST_FILE
        fi
      docker push $TAG
    done
}

if [ "$ACADEMY_HUB_USER" ]; then
  docker login -u $ACADEMY_HUB_USER -p $ACADEMY_HUB_PASSWORD ${ACADEMY_HUB_URL}
fi

BASE_DIR=$PWD
IMAGE_LIST=${1:-yointly,codx-dind}
shift
for d in ${IMAGE_LIST//,/ } ; do
  cd $d
  build_image $@ || true
  cd $BASE_DIR
done