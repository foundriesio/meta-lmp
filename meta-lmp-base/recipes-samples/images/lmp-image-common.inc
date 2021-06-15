FILESEXTRAPATHS_prepend := "${THISDIR}/configs:"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

# Always create vmdk and vdi images for the compatible targets
IMAGE_FSTYPES_append_intel-corei7-64 = " wic.vmdk wic.vdi"

inherit core-image features_check extrausers

SRC_URI = "\
    file://sudoers \
"

# In most cases the rootfs will be expanded to fit available storage
# However, for QEMU targets we need to pre-allocate enough free space
# for a full image update
IMAGE_OVERHEAD_FACTOR_qemuriscv64 ?= "2.3"
IMAGE_OVERHEAD_FACTOR_qemuarm64 ?= "2.3"
IMAGE_OVERHEAD_FACTOR_qemuarm ?= "2.3"
IMAGE_OVERHEAD_FACTOR_intel-corei7-64 ?= "2.3"

# let's make sure we have a good image..
REQUIRED_DISTRO_FEATURES = "pam systemd"

# Base packages
CORE_IMAGE_BASE_INSTALL += " \
    lmp-boot-firmware \
    networkmanager \
    nss-altfiles \
    resize-helper \
    sudo \
"

# Configure NSS ALTFILES based on NSS_ALT_TYPES
configure_rootfs_nss_altfiles () {
    # Supported types: hosts, pwd, grp, spwd and sgrp.
    for type in `echo ${NSS_ALT_TYPES} | tr ',' ' '`; do
        case $type in
            hosts) sysconf_file="hosts" ;;
            pwd) sysconf_file="passwd" ;;
            grp) sysconf_file="group" ;;
            spwd) sysconf_file="shadow" ;;
            sgrp) sysconf_file="gshadow" ;;
            *) continue ;;
        esac
        cp -a ${IMAGE_ROOTFS}${sysconfdir}/${sysconf_file} ${IMAGE_ROOTFS}${libdir}
        echo "# Default file provided via NSS altfiles at ${libdir}/${sysconf_file}" > ${IMAGE_ROOTFS}${sysconfdir}/${sysconf_file}
        # NSS altfiles should be right after files
        sed -i -e "/^${sysconf_file}/s/files/files altfiles/" ${IMAGE_ROOTFS}${sysconfdir}/nsswitch.conf

        # Defaults which can later be replaced by the user
        if [ "$type" = "hosts" ]; then
            cat ${IMAGE_ROOTFS}${libdir}/${sysconf_file} >> ${IMAGE_ROOTFS}${sysconfdir}/${sysconf_file}
        elif [ "$type" = "pwd" ]; then
            grep "^${LMP_USER}:" ${IMAGE_ROOTFS}${libdir}/${sysconf_file} >> ${IMAGE_ROOTFS}${sysconfdir}/${sysconf_file}
        fi
    done
}

fakeroot do_populate_rootfs_common_src () {
    # Allow sudo group users to use sudo
    install -m 0440 ${WORKDIR}/sudoers ${IMAGE_ROOTFS}${sysconfdir}/sudoers.d/50-lmp
}

IMAGE_PREPROCESS_COMMAND += "do_populate_rootfs_common_src; "
IMAGE_PREPROCESS_COMMAND += "${@bb.utils.contains('CORE_IMAGE_BASE_INSTALL', 'nss-altfiles', 'configure_rootfs_nss_altfiles; ', '',d)} "

addtask rootfs after do_unpack

python () {
    # Ensure we run these usually noexec tasks
    d.delVarFlag("do_fetch", "noexec")
    d.delVarFlag("do_unpack", "noexec")
}

EXTRA_USERS_PARAMS = "\
groupadd ${LMP_USER}; \
useradd -P ${LMP_PASSWORD} ${LMP_USER}; \
usermod -a -G sudo,users,plugdev ${LMP_USER}; \
"
