#!/bin/bash

# Cleanup existing Joplin folder, if it exists.
rm -rf joplin

git clone https://github.com/laurent22/joplin.git
cd joplin

# Change this line to change the version being built.
git checkout v2.12.16

yarn install

# Sometimes the build doesn't work correctly without running yarn install twice.
yarn install

cd packages/app-desktop

# Update package.json so .deb package can be built.
jq '.author |= {"name": "Laurent Cozic", "email": "laurent@cozic.net"}' package.json > package_new.json
jq '.build += {"deb": {"compression": "gz"}}' package_new.json > package.json
jq '.name = "Joplin"' package.json > package_new.json
mv package_new.json package.json

# System fpm must be used as the provided fpm does not work on arm.
export USE_SYSTEM_FPM=true

# Package the app as a .deb package and an AppImage.
npx electron-builder --arm64 --linux deb AppImage
