#!/bin/bash

set -e

git clone https://github.com/laurent22/joplin.git

cd joplin
git checkout v2.5.10

# Build steps taken from https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=joplin&id=d6b77dbf1fc62216a3d887c7c105d5847f8f73d6

sed -i '/"husky": ".*"/d' package.json

mkdir npm_cache
cd npm_cache

cache="`pwd`"

cd ..

jq ".packages = [
        \"packages/app-cli\", \"packages/app-desktop\",
        \"packages/fork-htmlparser2\", \"packages/fork-sax\",
        \"packages/lib\", \"packages/renderer\", \"packages/tools\",
        \"packages/turndown\", \"packages/turndown-plugin-gfm\"
        ] |
      . += {\"npmClient\": \"npm\", \"npmClientArgs\": [\"--cache $cache\"]}" lerna.json > lerna_new.json
mv lerna_new.json lerna.json

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
