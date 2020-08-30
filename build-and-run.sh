#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

sudo rm -rf output
mkdir output
chmod 777 output

sudo docker build --tag build-joplin-arm7h . && sudo docker run --rm -v "$DIR/output:/home/builder/output" build-joplin-arm7h
