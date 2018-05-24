SUMMARY = "Basic console-based gateway image"

IMAGE_FEATURES += "ssh-server-openssh"
IMAGE_FSTYPES_append_intel-corei7-64 = " wic.vmdk wic.vdi"

FILESEXTRAPATHS_prepend := "${THISDIR}/configs:"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit core-image distro_features_check extrausers

SRC_URI = "\
    file://bt-6lowpan.network \
    file://modules-6lowpan.conf \
    file://sysctl-panic.conf \
    file://path-sbin.sh \
    file://sudoers \
"

# let's make sure we have a good image..
REQUIRED_DISTRO_FEATURES = "pam systemd"

# Base packages
CORE_IMAGE_BASE_INSTALL += " \
    96boards-tools \
    coreutils \
    cpufrequtils \
    ldd \
    gptfdisk \
    hostapd \
    htop \
    iptables \
    kernel-modules \
    networkmanager \
    networkmanager-nmtui \
    ${@bb.utils.contains("MACHINE_FEATURES", "optee", "optee-test optee-client", "", d)} \
    rsync \
    sshfs-fuse \
"

CORE_IMAGE_BASE_INSTALL += " \
    aktualizr-host-tools \
    docker \
    bluez5-noinst-tools \
    git \
    linux-firmware-ar3k \
    linux-firmware-ath9k \
    linux-firmware-ath10k \
    linux-firmware-qca \
    linux-firmware-wl18xx \
    openssh-sftp-server \
    packagegroup-core-full-cmdline-utils \
    packagegroup-core-full-cmdline-extended \
    packagegroup-core-full-cmdline-multiuser \
    python3-compression \
    python3-distutils \
    python3-docker \
    python3-docker-compose \
    python3-json \
    python3-netclient \
    python3-pkgutil \
    python3-shell \
    python3-unixadmin \
    pciutils \
    strace \
    tcpdump \
    vim-tiny \
"

fakeroot do_populate_rootfs_src () {
    # Allow sudo group users to use sudo
    install -m 0440 ${WORKDIR}/sudoers ${IMAGE_ROOTFS}${sysconfdir}/sudoers.d/lmp

    # Configs that are specific to this image
    install -m 0644 ${WORKDIR}/bt-6lowpan.network ${IMAGE_ROOTFS}${exec_prefix}/lib/systemd/network/60-bt-6lowpan.network
    install -m 0644 ${WORKDIR}/modules-6lowpan.conf ${IMAGE_ROOTFS}${exec_prefix}/lib/modules-load.d/6lowpan.conf
    install -m 0644 ${WORKDIR}/sysctl-panic.conf ${IMAGE_ROOTFS}${exec_prefix}/lib/sysctl.d/60-panic.conf

    # Disable bluetooth service by default (allow to be contained in docker)
    ln -sf /dev/null ${IMAGE_ROOTFS}/etc/systemd/system/bluetooth.service

    # Useful for development
    install -d ${IMAGE_ROOTFS}${sysconfdir}/profile.d
    install -m 0644 ${WORKDIR}/path-sbin.sh ${IMAGE_ROOTFS}${sysconfdir}/profile.d/path-sbin.sh
}

IMAGE_PREPROCESS_COMMAND += "do_populate_rootfs_src; "

addtask rootfs after do_unpack

python () {
    # Ensure we run these usually noexec tasks
    d.delVarFlag("do_fetch", "noexec")
    d.delVarFlag("do_unpack", "noexec")
}

# docker pulls runc/containerd, which in turn recommend lxc unecessarily
BAD_RECOMMENDATIONS_append = " lxc"

EXTRA_USERS_PARAMS = "\
useradd -P osf osf; \
usermod -a -G docker,sudo,users,plugdev osf; \
"
