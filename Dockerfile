## Base image to use
FROM alpine

LABEL io.k8s.description="CouchPotato" \
      io.k8s.display-name="Couchpotato" \
      io.openshift.expose-services="5050" \
      io.openshift.tags="couchpotato"

## Maintainer info
MAINTAINER Nicolas Bigler <https://github.com/Bigluu>

# set python to use utf-8 rather than ascii.
ENV PYTHONIOENCODING="UTF-8"

## Update base image and install prerequisites
RUN apk add --update git python && \
  rm -rf /var/cache/apk/*

## Install Couchpotato
RUN mkdir /opt && \
  cd /opt && \
  git clone --depth 1 https://github.com/CouchPotato/CouchPotatoServer /opt/couchpotato && \
  chmod -R a+rwx /opt/couchpotato && \
  chown -R 1001:0 /opt/couchpotato

## Expose port
EXPOSE 5050

## Set working directory
WORKDIR /opt/couchpotato

VOLUME /config /downloads /movies

USER 1001

## Run Couchpotato
ENTRYPOINT ["python", "CouchPotato.py"]
