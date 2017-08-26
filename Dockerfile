FROM alpine:latest

LABEL MAINTAINER="Paul Steinlechner"

ENV TIMEZONE=Europe/Paris

COPY rootfs /

RUN echo \
  # replacing default repositories with edge ones
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" > /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
  && apk add --no-cache \
     bash \
     wget \
     unzip \
     xvfb \
     supervisor \
     py-pip \
     wine \
 && pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir crudini \

EXPOSE 7777/udp \
       27015/udp \
       27016/udp \
       37015/udp \
       37016/udp

VOLUME ["/conanexiles"]

ENTRYPOINT ["/entrypoint.sh"]
cmd ["/usr/bin/supervisord"]

