FROM debian:buster

RUN apt-get update && apt-get dist-upgrade -y && apt-get -y install curl && curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get -y install nodejs build-essential git jq libsecret-1-dev rsync python ruby-full libnss3
RUN npm install -g npm
RUN gem install --no-document fpm

RUN groupadd -r builder && useradd -m -r -g builder builder
USER builder

COPY build.sh /home/builder
WORKDIR /home/builder

ENTRYPOINT ["/bin/bash", "./build.sh"]
