#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

sudo docker build --tag build-joplin-arm7h . && sudo docker run --rm -v "$DIR/output:/opt/output" build-joplin-arm7h
