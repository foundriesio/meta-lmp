FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Disable PTEST for ostree as it requires options that are not enabled when
# building with meta-updater and meta-lmp.
PTEST_ENABLED = "0"

SRC_URI:append = " \
    file://0002-Allow-updating-files-in-the-boot-directory.patch \
    file://0003-u-boot-add-bootdir-to-the-generated-uEnv.txt.patch \
    file://0004-ostree-decrease-default-grub.cfg-timeout-and-set-def.patch \
"
SD_BOOT_PATCHES:append = " \
    file://0001-sysroot-deploy-systemd-boot-efi-to-ESP-partition.patch \
"

PACKAGECONFIG:remove = "static"
