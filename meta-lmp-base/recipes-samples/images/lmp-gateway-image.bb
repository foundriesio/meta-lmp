SUMMARY = "Basic console-based gateway image"

require lmp-image-common.inc

require ${@bb.utils.contains('DISTRO_FEATURES', 'sota', 'lmp-feature-factory.inc', '', d)}
require lmp-feature-ota-utils.inc
require lmp-feature-wireguard.inc
require lmp-feature-docker.inc
require lmp-feature-bluetooth.inc
require lmp-feature-wifi.inc
require lmp-feature-nat64.inc
require lmp-feature-jobserv.inc
require lmp-feature-debug.inc
require lmp-feature-softhsm.inc
require lmp-feature-sysctl-hang-crash-helper.inc
require lmp-feature-sysctl-net-queue-pfifo-fast.inc

require ${@bb.utils.contains('MACHINE_FEATURES', 'optee', 'lmp-feature-optee.inc', '', d)}

BT_6LOWPAN_NETWORK = "fe80:0:0:0:d4e7::1/80"
require lmp-feature-bt-6lowpan.inc

require lmp-service-bluetooth-disable.inc
require ${@bb.utils.contains('SOTA_CLIENT', 'aktualizr', 'lmp-service-ostree-pending-reboot.inc', '', d)}

IMAGE_FEATURES += "ssh-server-openssh"

# Base packages
CORE_IMAGE_BASE_INSTALL += " \
    coreutils \
    cpufrequtils \
    ldd \
    gptfdisk \
    iptables \
    kernel-modules \
    networkmanager-nmtui \
"

CORE_IMAGE_BASE_INSTALL += " \
    ethtool \
    git \
    less \
    packagegroup-core-full-cmdline-utils \
    packagegroup-core-full-cmdline-multiuser \
    pciutils \
"
