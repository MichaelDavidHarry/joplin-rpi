#!/bin/bash

set -e

sudo mkdir -p chroot
sudo debootstrap --no-check-gpg --arch armhf bullseye chroot http://raspbian.mirror.constant.com/raspbian/

sudo cp install-dependencies.sh ./chroot
sudo cp build.sh ./chroot

sudo ./mount-chroot.sh

sudo chroot ./chroot ./install-dependencies.sh

sudo ./unmount-chroot.sh
