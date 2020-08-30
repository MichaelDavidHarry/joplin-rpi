FROM debian

RUN apt-get update && apt-get dist-upgrade -y && apt-get -y install build-essential git npm jq libsecret-1-dev

COPY build.sh /opt
COPY author.json /opt
WORKDIR /opt

ENTRYPOINT ["/bin/bash", "./build.sh"]
