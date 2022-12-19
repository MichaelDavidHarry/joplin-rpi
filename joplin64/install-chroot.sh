#!/bin/bash

set -e

sudo mkdir -p chroot
sudo debootstrap --no-check-gpg --arch arm64 bullseye chroot http://deb.debian.org/debian

sudo cp install-dependencies.sh ./chroot
sudo cp build.sh ./chroot

sudo ./mount-chroot.sh

sudo chroot ./chroot ./install-dependencies.sh

sudo ./unmount-chroot.sh
