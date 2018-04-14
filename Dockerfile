FROM alpine

LABEL maintainer "Taichi Hagiwara <xagiwara@gmail.com>"

ENV VERSION 4.1.20

RUN apk update \
    && apk upgrade \
    # install packages
    && apk add libevent \
               openssl \
    && apk add --virtual=dev-packs \
               ca-certificates \
               g++ \
               libevent-dev \
               make \
               openssl-dev \
               wget \
    # download / extract
    && mkdir /usr/local/src \
    && wget -O - "https://nlnetlabs.nl/downloads/nsd/nsd-${VERSION}.tar.gz" | tar zxf -  -C /usr/local/src \
    && cd /usr/local/src/nsd-${VERSION} \
    # build
    && ./configure \
    && make install clean \
    # cleanup
    && cd / \
    && rm -rf /usr/local/src \
    && apk del dev-packs