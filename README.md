# buildJetsonXavierKernel / buildJetsonOrinKernel
Scripts to help build the 5.10.65 kernel and modules onboard the Jetson AGX Xavier/Orin (L4T 34.1.1, JetPack 5.0.1). For previous versions, visit the 'tags' section.

<em><strong>Note:</strong> The kernel source version must match the version of firmware flashed on the Jetson. For example, the source for the 5.10.65 kernel here is matched with L4T 34.1.1. This kernel compiled using this source tree will not work with newer versions or older versions of L4T, only 34.1.1.</em>

<em><strong>Note:</strong> You will probably only use these scripts to build and install modules. Even though there are scripts provided to build and copy the new kernel to the boot directory of the device, there is no effect. In newer versions of L4T, the kernel Image is actually signed and stored in a different partition on disk. The copyImage.sh script is legacy. In order to place the newly created Image, you will need to copy it to the correct place on the host and flash the eMMC. It is probably easier to build it on the host in the first place. The flash process on the host signs the Image, and copies it to the appropriate partition.</em>

As of this writing, the "official" way to build the Jetson AGX Xavier/Orin kernel is to use a cross compiler on a Linux PC. This is an alternative which builds the kernel onboard the Jetson itself. These scripts will download the kernel source to the Jetson AGX Xavier/Orin, and then compile the kernel and selected modules. The newly compiled kernel can then be installed. The kernel sources and build objects consume ~3GB.

These scripts are for building the kernel for the 64-bit L4T 34.1.1 (Ubuntu 18.04 based) operating system on the NVIDIA Jetson AGX Xavier/Orin. The scripts should be run directly after flashing the Jetson with L4T 34.1.1 from a host PC. There are six scripts:

<strong>getKernelSources.sh</strong>

Downloads the kernel sources for L4T from the NVIDIA website, decompresses them and opens a graphical editor on the .config file. Note that this also sets the .config file to the current system, and also sets the local version to the current local version, i.e., -tegra

<strong>makeKernel.sh</strong>

Compiles the kernel using make. The script commands make the kernel Image file. Installing the Image file on to the system is a separate step. Note that the make is limited to the Image and modules.

The other parts of the kernel build, such as building the device tree, require that the result be 'signed' and flashed from the the NVIDIA tools on a host PC.

<strong>makeModules.sh</strong>

Compiles the modules using make and then installs them.

<strong>copyImage.sh</strong>

Copies the Image file created by compiling the kernel to the /boot directory. Note that while developing you will want to be more conservative than this: You will probably want to copy the new kernel Image to a different name in the boot directory, and modify /boot/extlinux/extlinux.conf to have entry points at the old image, or the new image. This way, if things go sideways you can still boot the machine using the serial console.

You will want to make a copy of the original Image before the copy, something like:

```
$ cp /boot/Image $INSTALL_DIR/Image.orig
$ ./copyImage.sh
$ echo "New Image created and placed in /boot"
```

<strong>editConfig.sh</strong>

Edit the .config file located in /usr/src/kernel/kernel-5.10 This file must be present (from the getKernelSources.sh script) before launching the file. Note that if you change the local version, you will need to make both the kernel and modules and install them.

<strong>removeAllKernelSources.sh</strong>

Removes all of the kernel sources and compressed source files. You may want to make a backup of the files before deletion.


<h2>Notes:</h2>
<h3>Make sure to update the eMMC</h3>

The copyImage.sh script copies the Image to the current device. If you are building the kernel on an external device, for example a SSD, you will probably want to copy the Image file over to the eMMC in the eMMC's /boot directory. The Jetson will usually try to boot from the eMMC before switching to a different device. Study the boot sequence of the Jetson to properly understand which Image file is being used.

### Release Notes

January, 2020
* Initial release
* vL4T32.3.1
* L4T 32.3.1 (JetPack 4.3)

June, 2021
* vL4T32.5.1
* L4T 32.5.1 (JetPack 4.5.1)

June, 2022
* vL4T34.1.1
* L4T 34.1.1 (JetPack 5.0.1)

## License
MIT License

Copyright (c) 2017-2021 Jetsonhacks, julian3xl

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
