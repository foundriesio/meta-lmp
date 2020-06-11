FILESEXTRAPATHS_prepend := "${THISDIR}/configs:"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

# Always create vmdk, vdi and hddimg images for the compatible targets
IMAGE_FSTYPES_append_intel-corei7-64 = " wic.vmdk wic.vdi \
    ${@bb.utils.contains('EXTRA_IMAGE_FEATURES', 'ptest-pkgs', '', 'hddimg', d)}"

inherit core-image features_check extrausers

SRC_URI = "\
    file://sudoers \
"

# Enough free space for a full image update
IMAGE_OVERHEAD_FACTOR = "2.3"

# let's make sure we have a good image..
REQUIRED_DISTRO_FEATURES = "pam systemd"

# Base packages
CORE_IMAGE_BASE_INSTALL += " \
    networkmanager \
    resize-helper \
    sudo \
"

fakeroot do_populate_rootfs_common_src () {
    # Allow sudo group users to use sudo
    install -m 0440 ${WORKDIR}/sudoers ${IMAGE_ROOTFS}${sysconfdir}/sudoers.d/lmp
}

IMAGE_PREPROCESS_COMMAND += "do_populate_rootfs_common_src; "

addtask rootfs after do_unpack

python () {
    # Ensure we run these usually noexec tasks
    d.delVarFlag("do_fetch", "noexec")
    d.delVarFlag("do_unpack", "noexec")
}

EXTRA_USERS_PARAMS = "\
useradd -P ${LMP_USER} ${LMP_PASSWORD}; \
usermod -a -G sudo,users,plugdev ${LMP_USER}; \
"
