DESCRIPTION = "Kernel driver that implements SoftMAC 802.15.4 protocol based \
on atusb driver for ATUSB IEEE 802.15.4 dongle."
SUMMARY = "SoftMAC 802.15.4 kernel driver"
HOMEPAGE = "https://github.com/foundriesio/wpanusb"
SECTION = "kernel/network"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "git://github.com/foundriesio/wpanusb.git;protocol=https"

SRCREV = "a2b0a385d71861923524d35badaed172d3109fdd"

S = "${WORKDIR}/git"

inherit module

EXTRA_OEMAKE += 'ARCH="${ARCH}" CROSS_COMPILE="${TARGET_PREFIX}" \
    KDIR="${STAGING_KERNEL_DIR}" KERNEL_VERSION="${KERNEL_VERSION}" \
    KBUILD_EXTRA_SYMBOLS="${KBUILD_EXTRA_SYMBOLS}" \
'

do_install() {
    install -d ${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/wpanusb
    install -m 0755 ${S}/wpanusb.ko \
            ${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/wpanusb/
}
