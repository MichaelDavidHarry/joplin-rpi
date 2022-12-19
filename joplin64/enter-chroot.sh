#!/bin/bash

./mount-chroot.sh

sudo chroot ./chroot /bin/bash --login
