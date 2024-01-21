#!/bin/bash

# Cleanup existing Joplin folder, if it exists.
rm -rf joplin

git clone https://github.com/laurent22/joplin.git
cd joplin

# Change this line to change the version being built.
git checkout v2.13.15

# Disable parallel cloning and set compression to minimum level to lessen memory demand
echo 'cloneConcurrency: 1' >> .yarnrc.yml
echo 'compressionLevel: 0' >> .yarnrc.yml

# This process can fail (probably due to the node process hitting the 32-bit memory limit), but it should resume where it left off on subsequent tries.
# Yarn hangs without exiting sometimes, so we're forcing it to close after 5 minutes. After 2 attempts the packages should be installed.
timeout 5m yarn install
timeout 5m yarn install
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
npx electron-builder --armv7l --linux deb AppImage
