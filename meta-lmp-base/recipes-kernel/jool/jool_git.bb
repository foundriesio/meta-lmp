DESCRIPTION = "Jool is an Open Source SIIT and NAT64 for Linux"
SUMMARY = "SIIT and NAT64 for Linux"
HOMEPAGE = "https://www.jool.mx"
SECTION = "kernel/network"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${S}/COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"

SRC_URI = "git://github.com/NICMx/Jool.git;protocol=https;branch=main"

PV = "4.0.4"
SRCREV = "4c3e99d00242cf54832985fbe5374225512de3d5"

S = "${WORKDIR}/git"

inherit module

EXTRA_OEMAKE += 'ARCH="${ARCH}" CROSS_COMPILE="${TARGET_PREFIX}" \
    KERNEL_DIR="${STAGING_KERNEL_DIR}" KERNEL_VERSION="${KERNEL_VERSION}" \
    KBUILD_EXTRA_SYMBOLS="${KBUILD_EXTRA_SYMBOLS}" \
'

do_compile() {
    # Only build the kernel modules
    unset CFLAGS CPPFLAGS CXXFLAGS LDFLAGS
    oe_runmake -C "${S}/src/mod/nat64" CC="${KERNEL_CC}" LD="${KERNEL_LD}" \
            AR="${KERNEL_AR}" O=${STAGING_KERNEL_BUILDDIR}
    oe_runmake -C "${S}/src/mod/siit" CC="${KERNEL_CC}" LD="${KERNEL_LD}" \
            AR="${KERNEL_AR}" O=${STAGING_KERNEL_BUILDDIR}
}

do_install() {
    install -d ${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/jool
    install -m 0755 ${S}/src/mod/nat64/jool.ko \
            ${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/jool/
    install -m 0755 ${S}/src/mod/siit/jool_siit.ko \
            ${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/jool/
}
