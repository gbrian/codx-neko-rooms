FROM neko/firefox


RUN echo deb http://deb.debian.org/debian-security/ bullseye-security main contrib >> /etc/apt/sources.list

RUN apt update && apt install -y curl

RUN curl -sL http://security.debian.org/debian-security/pool/updates/main/g/glibc/libc6_2.31-13+deb11u7_amd64.deb > libc6_2.31-13+deb11u7_amd64.deb
RUN apt install -y ./libc6_2.31-13+deb11u7_amd64.deb; \
    rm libc6_2.31-13+deb11u7_amd64.deb

# systemctl
RUN curl -sL "https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl.py" > /usr/bin/systemctl