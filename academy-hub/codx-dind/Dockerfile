# https://hub.docker.com/_/docker
FROM docker:dind

# docker-compose
# https://github.com/tiangolo/docker-with-compose
RUN apk add --no-cache py3-pip python3-dev libffi-dev openssl-dev curl gcc libc-dev rust cargo make && \
    pip3 install --no-cache-dir docker-compose

COPY codx-entrypoint.sh /codx-entrypoint.sh
RUN chmod +x /codx-entrypoint.sh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY docker-compose.yaml /docker-compose.yaml

# codx user
RUN adduser --uid 1001 --gid 1001 --gecos '' --disabled-password codx && \
  echo "codx ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

RUN groupadd docker
RUN usermod -aG docker codx

# shared directory
RUN mkdir shared
RUN chmod 666 shared

RUN mkdir shared/codx
RUN chown codx shared/codx

ENTRYPOINT [ "/entrypoint.sh" ]