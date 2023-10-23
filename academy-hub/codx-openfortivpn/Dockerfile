FROM ubuntu:mantic

RUN apt update && \
    apt install -y openfortivpn && \
    mknod /dev/ppp c 108 0

COPY connect.sh /connect.sh
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]