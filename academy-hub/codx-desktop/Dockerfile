FROM m1k1o/neko:base as neko

FROM ubuntu:latest

#
# avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

#
# set custom user
ARG USERNAME=neko
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Ubuntu sources
RUN echo "deb http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse" >> /etc/apt/sources.list

RUN echo "deb http://archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list

RUN echo "deb http://archive.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://archive.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list

RUN echo "deb http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list

RUN echo "deb http://archive.canonical.com/ubuntu focal partner" >> /etc/apt/sources.list
RUN echo "deb-src http://archive.canonical.com/ubuntu focal partner" >> /etc/apt/sources.list

RUN set -eux; \
    apt-get update; \
    #
    # install dependencies
    apt-get install -y --no-install-recommends wget ca-certificates supervisor; \
    apt-get install -y --no-install-recommends pulseaudio dbus-x11 xserver-xorg-video-dummy; \
    apt-get install -y --no-install-recommends libcairo2 libxcb1 libxrandr2 libxv1 libopus0 libvpx6; \
    #
    # gst
    apt-get install -y --no-install-recommends libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
                    gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-pulseaudio; \
    #
    # install fonts
    apt-get install -y --no-install-recommends \
        # Google emojis
        fonts-noto-color-emoji \
        # Japanese fonts
        fonts-takao-mincho \
        # Chinese fonts
        fonts-wqy-zenhei xfonts-intl-chinese xfonts-wqy \
        # Korean fonts
        fonts-wqy-microhei; \
    #
    # create a non-root user
    groupadd --gid $USER_GID $USERNAME; \
    useradd --uid $USER_UID --gid $USERNAME --shell /bin/bash --create-home $USERNAME; \
    adduser $USERNAME audio; \
    adduser $USERNAME video; \
    adduser $USERNAME pulse; \
    #
    # workaround for an X11 problem: http://blog.tigerteufel.de/?p=476
    mkdir /tmp/.X11-unix; \
    chmod 1777 /tmp/.X11-unix; \
    chown $USERNAME /tmp/.X11-unix/; \
    #
    # make directories for neko
    mkdir -p /etc/neko /var/www /var/log/neko \
        /tmp/runtime-$USERNAME \
        /home/$USERNAME/.config/pulse  \
        /home/$USERNAME/.local/share/xorg; \
    chmod 1777 /var/log/neko; \
    chown $USERNAME /var/log/neko/ /tmp/runtime-$USERNAME; \
    chown -R $USERNAME:$USERNAME /home/$USERNAME; \
    #
    # clean up
    apt-get clean -y; \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# systemctl alternative
RUN wget -O "/usr/bin/systemctl" "https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py"
RUN chmod +x /usr/bin/systemctl


#
# copy config files
COPY --from=neko /usr/bin/dbus /usr/bin/dbus
COPY --from=neko /etc/pulse/default.pa /etc/pulse/default.pa
COPY --from=neko /etc/neko/supervisord.conf /etc/neko/supervisord.conf
COPY --from=neko /etc/neko/xorg.conf /etc/neko/xorg.conf 

#
# set default envs
ENV USER=$USERNAME
ENV DISPLAY=:99.0
ENV PULSE_SERVER=unix:/tmp/pulseaudio.socket
ENV XDG_RUNTIME_DIR=/tmp/runtime-$USERNAME
ENV NEKO_PASSWORD=neko
ENV NEKO_PASSWORD_ADMIN=admin
ENV NEKO_BIND=:8080

#
# copy static files from previous stages
COPY --from=neko /usr/bin/neko /usr/bin/neko
COPY --from=neko /var/www /var/www 

#HEALTHCHECK --interval=10s --timeout=5s --retries=8 \
#    CMD wget -O - http://localhost:${NEKO_BIND#*:}/health || exit 1
#
# run neko
# CMD ["/usr/bin/supervisord", "-c", "/etc/neko/supervisord.conf"]

COPY services /etc/neko