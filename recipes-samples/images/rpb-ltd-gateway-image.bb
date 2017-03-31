SUMMARY = "Basic console-based gateway image"

IMAGE_FEATURES += "splash package-management ssh-server-openssh hwcodecs tools-debug"

LICENSE = "MIT"

inherit core-image distro_features_check extrausers

# let's make sure we have a good image..
REQUIRED_DISTRO_FEATURES = "pam systemd"

CORE_IMAGE_BASE_INSTALL += " \
    packagegroup-core-full-cmdline-utils \
    packagegroup-core-full-cmdline-extended \
    packagegroup-core-full-cmdline-multiuser \
    packagegroup-rpb \
    tcpdump \
    pciutils \
"

fakeroot do_populate_rootfs_src () {
    # Allow sudo group users to use sudo
    echo "%sudo ALL=(ALL) ALL" >> ${IMAGE_ROOTFS}/etc/sudoers

    # Disable bluetooth service by default (allow to be contained in docker)
    ln -sf /dev/null ${IMAGE_ROOTFS}/etc/systemd/system/bluetooth.service
}

IMAGE_PREPROCESS_COMMAND += "do_populate_rootfs_src; "

EXTRA_USERS_PARAMS = "\
useradd -P linaro linaro; \
usermod -a -G docker,sudo,users,plugdev linaro; \
"
