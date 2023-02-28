# USB support requires firmware to be available in the initrd
PACKAGE_INSTALL:append:tegra = " tegra-firmware-xusb"
