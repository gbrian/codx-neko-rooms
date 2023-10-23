set -e

source ./env.sh
echo "Pushing images"

function build_image {
    IMAGE_NAME=${PWD##*/}

    if test -f "$PWD/pre-build.sh"; then
      bash ./pre-build.sh
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