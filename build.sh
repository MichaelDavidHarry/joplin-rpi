#!/bin/bash

set -e

git clone https://github.com/laurent22/joplin.git

cd joplin
git checkout v1.5.11

# Build steps taken from https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=joplin&id=a3f942cecf06db5cbc0520467d4d6d4fcfb7db78

sed -i '/"husky": ".*"/d' package.json

export LANG=en_US.utf8

npm install

cd ./packages/app-desktop
jq '.author |= {"name": "Laurent Cozic", "email": "laurent@cozic.net"}' package.json > package_new.json
jq '.build += {"deb": {"compression": "gz"}}' package_new.json > package.json
jq '.name = "Joplin"' package.json > package_new.json
mv package_new.json package.json
export USE_SYSTEM_FPM=true
npm run dist -- --armv7l --linux deb AppImage

cp -r dist/*.deb dist/*.AppImage /home/builder/output/
