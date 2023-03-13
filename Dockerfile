FROM lsiobase/guacgui

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="xenobyter"
ENV APPNAME="Mediathekview" TERM=xterm

RUN \
    echo "**** install deps ****" && \
    apt-get update && \
    apt-get install -qy --no-install-recommends cron mediathekview &&\
    echo "**** clean up ****" && \
    rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# add local files
COPY /root /
COPY /crontab /etc
COPY /crond /config/custom-cont-init.d/crond
COPY --chmod=0755 /mediathekview /usr/bin/mediathekview

# ports and volumes
EXPOSE 8080
VOLUME /config