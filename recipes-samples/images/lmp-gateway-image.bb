SUMMARY = "Basic console-based gateway image"

require lmp-image-common.inc

IMAGE_FEATURES += "ssh-server-openssh"

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
    # Disable bluetooth service by default (allow to be contained in docker)
    ln -sf /dev/null ${IMAGE_ROOTFS}/etc/systemd/system/bluetooth.service
}

# docker pulls runc/containerd, which in turn recommend lxc unecessarily
BAD_RECOMMENDATIONS_append = " lxc"

IMAGE_PREPROCESS_COMMAND += "do_populate_rootfs_src; "

EXTRA_USERS_PARAMS += "\
usermod -a -G docker osf; \
"
