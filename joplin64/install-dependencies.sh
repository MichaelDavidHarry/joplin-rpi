#!/bin/bash

set -e

apt-get install -y curl

curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs git build-essential libnss3 libsecret-1-dev python rsync ruby-full jq

# The included fpm does not work for arm, so we install system fpm instead.
gem install --no-document fpm

npm install --global yarn
