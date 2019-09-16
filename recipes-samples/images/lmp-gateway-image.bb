SUMMARY = "Basic console-based gateway image"

require lmp-image-common.inc

require lmp-feature-ota-utils.inc
require lmp-feature-docker.inc
require lmp-feature-bluetooth.inc
require lmp-feature-wifi.inc
require lmp-feature-nat64.inc
require lmp-feature-debug.inc
require lmp-feature-sbin-path-helper.inc
require lmp-feature-sysctl-hang-crash-helper.inc
require lmp-feature-sysctl-net-queue-pfifo-fast.inc

BT_6LOWPAN_NETWORK = "fe80:0:0:0:d4e7::1/80"
require lmp-feature-bt-6lowpan.inc

require lmp-service-bluetooth-disable.inc
require lmp-service-ostree-pending-reboot.inc

IMAGE_FEATURES += "ssh-server-openssh"

# Enough free space for a full image update
IMAGE_OVERHEAD_FACTOR = "2.3"

# Base packages
CORE_IMAGE_BASE_INSTALL += " \
    coreutils \
    cpufrequtils \
    ldd \
    gptfdisk \
    iptables \
    kernel-modules \
    networkmanager-nmtui \
    ${@bb.utils.contains("MACHINE_FEATURES", "optee", "optee-os-ta optee-client optee-test optee-examples optee-sks pkcs11test", "", d)} \
"

CORE_IMAGE_BASE_INSTALL += " \
    ethtool \
    git \
    less \
    packagegroup-core-full-cmdline-utils \
    packagegroup-core-full-cmdline-extended \
    packagegroup-core-full-cmdline-multiuser \
    pciutils \
"
