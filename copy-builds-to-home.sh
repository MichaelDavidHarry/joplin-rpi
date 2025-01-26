#!/bin/bash

function copy_with_suffix_to_home(){
    path=$1
    suffix=$2

    for file in "$path"; do
        base=$(basename -- "$file")
        extension="${base##*.}"
        base="${base%.*}"
        cp "$file" "$HOME/${base}${suffix}.${extension}"
    done
}

copy_with_suffix_to_home joplin32/chroot/joplin/packages/app-desktop/dist/*.AppImage -armv7l
copy_with_suffix_to_home joplin32/chroot/joplin/packages/app-desktop/dist/*.deb -armv7l

copy_with_suffix_to_home joplin64/chroot/joplin/packages/app-desktop/dist/*.AppImage -arm64
copy_with_suffix_to_home joplin64/chroot/joplin/packages/app-desktop/dist/*.deb -arm64
