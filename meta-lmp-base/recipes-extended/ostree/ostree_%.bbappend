FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Disable PTEST for ostree as it requires options that are not enabled when
# building with meta-updater and meta-lmp.
PTEST_ENABLED = "0"

SRC_URI:append = " \
    file://0001-Allow-updating-files-in-the-boot-directory.patch \
    file://0002-u-boot-add-bootdir-to-the-generated-uEnv.txt.patch \
    file://0003-Add-support-for-directories-instead-of-symbolic-link.patch \
    file://0004-Add-support-for-systemd-boot-bootloader.patch \
    file://0005-ostree-decrease-default-grub.cfg-timeout-and-set-def.patch \
"

PACKAGECONFIG:remove = "static"
