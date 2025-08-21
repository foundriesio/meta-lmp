DESCRIPTION = "Jool is an Open Source SIIT and NAT64 for Linux"
SUMMARY = "SIIT and NAT64 for Linux"
HOMEPAGE = "https://www.jool.mx"
SECTION = "kernel/network"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${S}/COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"

SRC_URI = "git://github.com/NICMx/Jool.git;protocol=https;branch=main"

PV = "4.1.10"
SRCREV = "47334c9124b7a2e3253fb279e6c33acb9c2b09a6"

inherit module

EXTRA_OEMAKE += 'ARCH="${ARCH}" CROSS_COMPILE="${TARGET_PREFIX}" \
    KERNEL_DIR="${STAGING_KERNEL_DIR}" KERNEL_VERSION="${KERNEL_VERSION}" \
'

do_compile() {
    for module in common nat64 siit; do
        oe_runmake -C "${S}/src/mod/${module}" CC="${KERNEL_CC}" LD="${KERNEL_LD}" \
            AR="${KERNEL_AR}" O=${STAGING_KERNEL_BUILDDIR}
    done
}

do_install() {
    for module in common nat64 siit; do
        oe_runmake DEPMOD=echo MODLIB="${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}" \
            -C "${S}/src/mod/${module}" CC="${KERNEL_CC}" LD="${KERNEL_LD}" \
            AR="${KERNEL_AR}" O=${STAGING_KERNEL_BUILDDIR} modules_install
    done
}
