FROM alpine:3.4
MAINTAINER Joeri van Dooren <ure@mororless.be>

RUN apk update && apk add tzdata bash tar rsync  \
wget curl git vim unzip && \
apk upgrade && \
cp /usr/share/zoneinfo/Europe/Brussels /etc/localtime && \
echo "Europe/Brussels" >  /etc/timezone && \
curl https://install.meteor.com/ | sh && \
mkdir /app && cd /app && wget https://github.com/rsercano/mongoclient/archive/master.zip && \
unzip master.zip && rm -f master.zip && \
rm -f /var/cache/apk/*

ADD run.sh /app/run.sh

RUN mkdir //.meteor-install-tmp && chmod a+rwx / && chmod a+rwxt //.meteor-install-tmp && chmod a+x /app/run.sh && chmod -R a+rwx /app

# Exposed Port
EXPOSE 3000

WORKDIR /app/mongoclient-master

ENTRYPOINT ["/app/run.sh"]

# Set labels used in OpenShift to describe the builder images
LABEL io.k8s.description="Meteor" \
      io.k8s.display-name="Meteor alpine" \
      io.openshift.expose-services="3000:http" \
      io.openshift.tags="builder,Meteor" \
      io.openshift.min-memory="1Gi" \
      io.openshift.min-cpu="1" \
      io.openshift.non-scalable="false"
