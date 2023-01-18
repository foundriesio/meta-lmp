DESCRIPTION = "Security development tools for High-Security(HS) TI K3 processors."
HOMEPAGE = "https://git.ti.com/cgit/security-development-tools/core-secdev-k3"
SECTION = "devel"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://manifest/k3-secdev-0.2-manifest.html;md5=f632a78870cc64550078d7b3cbac0892"

# set a default value for TI_K3_SECDEV_INSTALL_DIR_RECIPE
export TI_K3_SECDEV_INSTALL_DIR_RECIPE = "${datadir}/ti/ti-k3-secdev"
include recipes-ti/includes/ti-paths.inc

# Native host tool only
COMPATIBLE_MACHINE = "null"
COMPATIBLE_MACHINE:class-native = "(.*)"
COMPATIBLE_MACHINE:class-nativesdk = "(.*)"

GIT_URI = "git://git.ti.com/git/security-development-tools/core-secdev-k3.git"
GIT_PROTOCOL = "https"
GIT_BRANCH = "master"
GIT_SRCREV = "eb2c4d734487e5095b94cef3fd7213ee71d9e016"

SRC_URI = "${GIT_URI};protocol=${GIT_PROTOCOL};branch=${GIT_BRANCH}"
SRCREV = "${GIT_SRCREV}"

S = "${WORKDIR}/git"

do_install() {
    CP_ARGS="-Prf --preserve=mode,links,timestamps --no-preserve=ownership"
    install -d ${D}${TI_K3_SECDEV_INSTALL_DIR_RECIPE}
    cp ${CP_ARGS} ${S}/* ${D}${TI_K3_SECDEV_INSTALL_DIR_RECIPE}
}

FILES:${PN} += "${TI_K3_SECDEV_INSTALL_DIR_RECIPE}"

INSANE_SKIP:${PN} = "arch ldflags file-rdeps"

INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_SYSROOT_STRIP = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"

BBCLASSEXTEND = "native nativesdk"
