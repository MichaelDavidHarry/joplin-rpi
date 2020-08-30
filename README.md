# joplin-armv7l

Unofficial .deb and AppImage build of [Joplin](https://joplinapp.org/) for ARM devices, such as the Raspberry Pi.

Uses Docker to build .deb package and AppImage.

To build, run the build-and-run.sh file. This will build the Docker image used for the build process, and then start a container of that image to build the .deb package and AppImage which will be output to the output directory.

This build only seems to work correctly on ARM. Building on x86 will create output .deb and AppImage files, but these will not run on an ARM device correctly (program launches, but no window ever appears).

Build has only been tested on a Raspberry Pi 4 running Raspberry Pi OS (2020-08-20).

Please don't bother the original author for issues related to this unofficial build.
