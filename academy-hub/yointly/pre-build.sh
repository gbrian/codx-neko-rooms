echo "**** PRE BUILD"
cd ../../neko \
  && docker build -f .docker/base/Dockerfile.ubuntu -t neko/base:ubuntu .
