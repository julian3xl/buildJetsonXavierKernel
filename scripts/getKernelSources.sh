#!/bin/bash
# Get Kernel sources for NVIDIA Jetson AGX Xavier/Orin
apt-add-repository universe
apt-get update
apt-get install pkg-config -y
# We use 'make menuconfig' to edit the .config file; install dependencies
apt-get install libncurses5-dev -y
echo "Installing kernel sources in: ""$SOURCE_TARGET"
if [ ! -d "$SOURCE_TARGET" ]; then
    # Target directory does not exist; create
    echo "Creating directory: ""$SOURCE_TARGET"
    mkdir -p "$SOURCE_TARGET"
fi

cd "$SOURCE_TARGET"
echo "$PWD"
wget -N https://developer.nvidia.com/embedded/l4t/r34_release_v1.1/sources/public_sources.tbz2
# l4t-sources is a tbz2 file
tar -xvf public_sources.tbz2  Linux_for_Tegra/source/public/kernel_src.tbz2 --strip-components=3
tar -xvf kernel_src.tbz2
# Space is tight; get rid of the compressed kernel source
rm -r kernel_src.tbz2
cd kernel/kernel-5.10
# Go get the default config file; this becomes the new system configuration
zcat /proc/config.gz > .config
# Make a backup of the original configuration
cp .config config.orig
# Default to the current local version
KERNEL_VERSION=$(uname -r)
# This removes the suffix
LOCAL_VERSION=${KERNEL_VERSION#$"5.10.65"}
# Should be "-tegra"
bash scripts/config --file .config --set-str LOCALVERSION $LOCAL_VERSION
