SUMMARY = "Base console image which includes OTA Lite, Docker, and OpenSSH support"

require lmp-image-common.inc

require lmp-feature-wireguard.inc
require lmp-feature-docker.inc
require lmp-feature-bluetooth.inc
require lmp-feature-wifi.inc
require lmp-feature-ota-utils.inc
require lmp-feature-softhsm.inc
require lmp-feature-jobserv.inc

require ${@bb.utils.contains('MACHINE_FEATURES', 'optee', 'lmp-feature-optee.inc', '', d)}

IMAGE_FEATURES += "ssh-server-openssh"

CORE_IMAGE_BASE_INSTALL += " \
    kernel-modules \
    networkmanager-nmtui \
    git \
    packagegroup-core-full-cmdline-extended \
"
