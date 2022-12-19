# joplin-rpi

Unofficial .deb and AppImage build of [Joplin](https://joplinapp.org/) for [Raspberry Pi OS](https://www.raspberrypi.com/software/).

Uses a chroot to build a .deb package and AppImage.

## Build Instructions
1. Install `debootstrap` if it is not already installed. (`sudo apt install debootstrap -y`).
2. Navigate to either the joplin32 or joplin64 directory. joplin32 will build the armhf package, joplin64 will build the aarch64 package.
3. Run `sudo ./install-chroot.sh`. This will create the chroot environment in a subfolder named chroot. This will probably take about 10 minutes.
4. Run `sudo ./enter-chroot.sh`. This will put your terminal into the chroot environment.
5. Run `./build.sh`. This will pull the Joplin code from GitHub and perform the build. This will probably take 1-2 hours.
**Note: The build of the web-clipper package will fail. This is expected on this platform.**
6. Once the build has completed, type `exit` to leave the chroot. Then run `./unmount-chroot.sh` to unmount any system mounts into the chroot.
7. The built .deb and .AppImage files will be available in chroot/joplin/packages/app-desktop/dist/.

## Scripts
* `build.sh` - Pulls code from the [Joplin GitHub repo](https://github.com/laurent22/joplin), checks out a specified commit or tag, and then builds the application. Change the `git checkout` line of this script to build a different version of Joplin.
* `cleanup.sh` - Runs `./unmount-chroot.sh`, then deletes the chroot directory.
* `enter-chroot.sh` - Runs `./mount-chroot.sh`, then runs a chroot command into the chroot directory. 
* `install-chroot.sh` - Creates the chroot directory and then runs debootstrap to install a Debian/Raspbian system into that directory. Then it copies the install-dependencies.sh script and the build.sh script into the chroot directory, and then runs the install-dependencies.sh script inside the chroot. Runs `./unmount-chroot.sh` when this process is complete.
* `install-dependencies.sh` - Installs the packages into the chroot environment that will be needed to build the Joplin app.
* `mount-chroot.sh` - Mounts system mounts into the chroot that the chroot will need.
* `unmount-chroot.sh` - Unmounts system mounts from the chroot.

## Notes
This build only seems to work correctly on ARM. Building on x86 will create output .deb and AppImage files, but these will not run on an ARM device correctly (program launches, but no window ever appears).

The build process has only been tested on a Raspberry Pi 4 (4 GB RAM) running 64-bit Raspberry Pi OS (2022-09-22).
The .deb and AppImage packages have been tested on a Raspberry Pi 4 running 64-bit Raspberry Pi OS (2022-09-22) for the 64-bit (aarch64) package, and on a Raspberry Pi 2 running 32-bit Raspberry Pi OS (2022-09-22) for the 32-bit (armhf) package.

Please don't bother the original author of Joplin for issues related to this unofficial build.
