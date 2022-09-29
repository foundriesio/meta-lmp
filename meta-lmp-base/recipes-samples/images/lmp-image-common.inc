FILESEXTRAPATHS:prepend := "${THISDIR}/configs:"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

# Always create vmdk, vdi and qcow2 images for the compatible targets
IMAGE_FSTYPES:append:intel-corei7-64 = " wic.vmdk wic.vdi wic.qcow2"

inherit core-image features_check extrausers

SRC_URI = "\
    file://sudoers \
"

# With luks we need to decrease the fs size, so give enough overhead
IMAGE_OVERHEAD_FACTOR = "${@bb.utils.contains('DISTRO_FEATURES', 'luks', '2.3', '1.3', d)}"

# Extra space required for LUKS (32MB)
IMAGE_ROOTFS_EXTRA_SPACE:append = "${@bb.utils.contains('DISTRO_FEATURES', 'luks', ' + 32768', '', d)}"

# In most cases the rootfs will be expanded to fit available storage
# However, for QEMU targets we need to pre-allocate enough free space
# for a full image update
IMAGE_OVERHEAD_FACTOR:qemuriscv64 ?= "2.3"
IMAGE_OVERHEAD_FACTOR:qemuarm64 ?= "2.3"
IMAGE_OVERHEAD_FACTOR:qemuarm ?= "2.3"
IMAGE_OVERHEAD_FACTOR:intel-corei7-64 ?= "2.3"
IMAGE_OVERHEAD_FACTOR:tegra ?= "2.3"

# let's make sure we have a good image..
REQUIRED_DISTRO_FEATURES = "pam systemd"

# Base packages
CORE_IMAGE_BASE_INSTALL += " \
    lmp-boot-firmware \
    networkmanager \
    nss-altfiles \
    pam-plugin-mkhomedir \
    resize-helper \
    mtd-utils \
    sudo \
    tzdata \
    zram \
"

# Additional packages when sota is available
CORE_IMAGE_BASE_INSTALL:append:sota = " \
    ostree-recovery-initramfs \
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
        elif [ "$type" = "pwd" ] || [ "$type" = "spwd" ]; then
            for pmember in ${ETC_PASSWD_MEMBERS}; do
                grep "^${pmember}:" ${IMAGE_ROOTFS}${libdir}/${sysconf_file} >> ${IMAGE_ROOTFS}${sysconfdir}/${sysconf_file} || true
            done
        elif [ "$type" = "grp" ]; then
            for gmember in ${ETC_GROUP_MEMBERS}; do
                grep "^${gmember}:" ${IMAGE_ROOTFS}${libdir}/${sysconf_file} >> ${IMAGE_ROOTFS}${sysconfdir}/${sysconf_file} || true
            done
        fi
    done
}

fakeroot do_populate_rootfs_common_src () {
    mkdir -p ${IMAGE_ROOTFS}${sysconfdir}/sudoers.d
    # Allow sudo group users to use sudo
    install -m 0440 ${WORKDIR}/sudoers ${IMAGE_ROOTFS}${sysconfdir}/sudoers.d/50-lmp

    # Enable pam_mkhomedir (requires pam-plugin-mkhomedir to be installed)
    echo "session required pam_mkhomedir.so silent skel=/etc/skel/ umask=0022" >> ${IMAGE_ROOTFS}${sysconfdir}/pam.d/common-session
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
useradd -p '${LMP_PASSWORD}' ${LMP_USER}; \
usermod -a -G sudo,users,audio,plugdev ${LMP_USER}; \
"
