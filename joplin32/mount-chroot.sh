#!/bin/bash

sudo mount -t proc proc ./chroot/proc
sudo mount -t devpts devpts ./chroot/dev/pts
