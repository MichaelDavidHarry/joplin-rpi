#!/bin/bash

set -e

git clone https://github.com/laurent22/joplin.git

cd joplin
git checkout master

export LANG=en_US.utf8

npm install --cache ./npm-cache execa
npm install --cache ./npm-cache

cd ElectronClient
npm install --cache ../npm-cache
jq -s add ./package.json /opt/author.json > package_new.json
mv package_new.json package.json
npm run dist -- --armv7l --linux deb AppImage

cp dist/*.deb /opt/output/
