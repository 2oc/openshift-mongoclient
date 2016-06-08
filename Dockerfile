FROM alpine:3.4
MAINTAINER Joeri van Dooren <ure@mororless.be>

RUN apk update && apk add tzdata bash tar rsync  \
wget curl git vim && \
apk upgrade && \
cp /usr/share/zoneinfo/Europe/Brussels /etc/localtime && \
echo "Europe/Brussels" >  /etc/timezone && \
rm -f /var/cache/apk/*

# Your app
ADD app/

# Exposed Port
EXPOSE 3000

# VOLUME /app
WORKDIR /app

ENTRYPOINT ["/app/run.sh"]

# Set labels used in OpenShift to describe the builder images
LABEL io.k8s.description="Meteor" \
      io.k8s.display-name="Meteor alpine" \
      io.openshift.expose-services="3000:http" \
      io.openshift.tags="builder,Meteor" \
      io.openshift.min-memory="1Gi" \
      io.openshift.min-cpu="1" \
      io.openshift.non-scalable="false"
