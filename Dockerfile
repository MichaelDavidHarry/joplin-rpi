FROM debian

RUN apt-get update && apt-get dist-upgrade -y && apt-get -y install build-essential git npm jq libsecret-1-dev rsync python ruby-full
RUN gem install --no-document fpm

RUN groupadd -r builder && useradd -m -r -g builder builder
USER builder

COPY build.sh /home/builder
WORKDIR /home/builder

ENTRYPOINT ["/bin/bash", "./build.sh"]