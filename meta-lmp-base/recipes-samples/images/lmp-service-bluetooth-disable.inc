# NOTE: should use lmp-feature-bluetooth.inc

fakeroot do_populate_rootfs_bluetooth_src () {
    # Disable bluetooth service by default (allow to be contained in docker)
    ln -sf /dev/null ${IMAGE_ROOTFS}/etc/systemd/system/bluetooth.service
}

IMAGE_PREPROCESS_COMMAND += "do_populate_rootfs_bluetooth_src; "
