#!/bin/bash
cd /usr/src/kernel/kernel-5.10
# On the stock Jetson AGX Xavier/Orin install, there is no zImage in the boot directory
# So we just copy the Image file over
# If the zImage is needed, you must either
# $ make zImage
# or
# $ make
# Both of these commands must be executed in /usr/src/kernel/kernel-5.10
# sudo cp arch/arm64/boot/zImage /boot/zImage
# Note that if you are compiling on an external device, like a SSD, you should probably
# copy this over to the internal eMMC if that is where the Jetson boots

if [ ! -e /boot/Image.orig ]; then mv /boot/Image /boot/Image.orig; fi
sudo cp arch/arm64/boot/Image /boot/Image
