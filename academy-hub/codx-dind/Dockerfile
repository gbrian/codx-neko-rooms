# https://hub.docker.com/_/docker
FROM docker:latest

RUN apk update && apk add docker

COPY codx-entrypoint.sh /codx-entrypoint.sh
RUN chmod +x /codx-entrypoint.sh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY docker-compose.yaml /docker-compose.yaml

# codx user
RUN adduser -u 1001 --gecos '' -D codx docker && \
  echo "codx ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

# shared directory
RUN mkdir shared
RUN chown codx shared

RUN mkdir shared/codx
RUN chown codx shared/codx

#
# set custom user
ARG USERNAME=neko
ARG USER_UID=1000
ARG USER_GID=$USER_UID


ENTRYPOINT [ "/entrypoint.sh" ]