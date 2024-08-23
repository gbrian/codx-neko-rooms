# https://hub.docker.com/_/docker
FROM docker:latest

RUN apk update && apk add docker

# codx user
ENV USER=codx
ENV GROUPNAME=docker
ENV UID=1000
ENV GID=1000

RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "$(pwd)" \
    --ingroup "$GROUPNAME" \
    --uid "$UID" \
    $USER

COPY codx-entrypoint.sh /codx-entrypoint.sh
RUN chmod +x /codx-entrypoint.sh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY docker-compose.yaml /docker-compose.yaml

RUN mkdir /shared
RUN chown codx /shared

ENTRYPOINT [ "/entrypoint.sh" ]