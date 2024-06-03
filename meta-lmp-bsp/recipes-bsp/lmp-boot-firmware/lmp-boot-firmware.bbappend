FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PROVIDES:uz3eg-iocc-sec = "virtual/boot-bin"
SRC_URI:uz3eg-iocc-sec = "file://boot.bin"

DEPENDS:append:tegra = "tegra-uefi-capsules"
RDEPENDS:${PN}:append:tegra = "setup-nv-boot-control"
SRC_URI:append:tegra = " \
    file://is_rollback.sh \
    file://set_bootok.sh \
    file://update_notify.sh \
"

do_install:append:tegra() {
    install -D -m 0755 ${S}/is_rollback.sh  ${D}${FIRMWARE_DEPLOY_DIR}
    install -D -m 0755 ${S}/set_bootok.sh  ${D}${FIRMWARE_DEPLOY_DIR}
    install -D -m 0755 ${S}/update_notify.sh  ${D}${FIRMWARE_DEPLOY_DIR}
}