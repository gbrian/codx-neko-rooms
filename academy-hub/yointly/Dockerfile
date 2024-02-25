FROM m1k1o/neko:firefox

RUN echo deb http://deb.debian.org/debian-security/ bullseye-security main contrib >> /etc/apt/sources.list

RUN apt update && apt install -y curl python

RUN curl -sL http://security.debian.org/debian-security/pool/updates/main/g/glibc/libc6_2.31-13+deb11u7_amd64.deb > libc6_2.31-13+deb11u7_amd64.deb
RUN apt install -y ./libc6_2.31-13+deb11u7_amd64.deb; \
    rm libc6_2.31-13+deb11u7_amd64.deb

# systemctl
RUN curl -sL "https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl.py" > /usr/bin/systemctl
RUN chmod +x /usr/bin/systemctl


RUN apt-get install -y locales jq sqlite3 locales sudo procps
# https://wiki.debian.org/Locale#Manually
RUN sed -i "s/# en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen 
RUN sed -i "s/# es_ES.UTF-8/es_ES.UTF-8/" /etc/locale.gen
RUN sed -i "s/# en_GB.UTF-8/en_GB.UTF-8/" /etc/locale.gen
RUN locale-gen

ENV LANG=en_US.UTF-8

ENV PATH=$PATH:/usr/share/code

ENV POLICIES_FILE=/usr/lib/firefox/distribution/policies.json
ENV CONFIG_FILE=/usr/lib/firefox/mozilla.cfg

COPY firefox/autoconfig.js /usr/lib/firefox/defaults/pref/autoconfig.js
COPY firefox/policies.json $POLICIES_FILE
COPY firefox/neko.js $CONFIG_FILE

COPY firefox/supervisord.conf /etc/neko/supervisord/firefox.conf

# userChrome.js
COPY firefox/chrome /home/neko/.mozilla/firefox/profile.default/chrome

COPY scripts /yointly
RUN cp -r /home/neko/.mozilla/firefox /yointly/firefox

# systemctl
RUN curl -sL "https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl.py" > /usr/bin/systemctl

CMD [ "bash", "-c", "/yointly/init-yointly.sh" ]
