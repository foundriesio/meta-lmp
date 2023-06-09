FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

include recipes-kernel/linux/kmeta-linux-lmp-6.1.y.inc

LINUX_VERSION ?= "6.1.26"
KBRANCH = "ti-linux-6.1.y"
SRCREV_machine = "1ada48a6cf0b8b731b835b9f1e1e4af89f8fb791"
SRCREV_meta = "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRC_URI = "git://git.ti.com/ti-linux-kernel/ti-linux-kernel.git;protocol=git;branch=${KBRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
    ${@bb.utils.contains('MACHINE_FEATURES', 'jailhouse', '${SRC_URI_JAILHOUSE}', '', d)} \
"

# Jailhouse patches and config
SRC_URI_JAILHOUSE = " \
    file://0001-arm64-dts-am654-base-board-Reserve-memory-for-jailho.patch \
    file://0002-arm64-dts-k3-am654-base-board-jailhouse-Disable-mcu_.patch \
    file://0003-mm-Re-export-ioremap_page_range.patch \
    file://0004-mm-vmalloc-Export-__get_vm_area_caller.patch \
    file://0005-arm-arm64-export-__hyp_stub_vectors.patch \
    file://0006-uio-Enable-read-only-mappings.patch \
    file://0007-ivshmem-Add-header-file.patch \
    file://0008-uio-Add-driver-for-inter-VM-shared-memory-device.patch \
    file://0009-ivshmem-net-virtual-network-device-for-Jailhouse.patch \
    file://0010-arm64-dts-disable-peripherals-for-am654x-root-cell.patch \
    file://0011-arm64-dts-expanded-k3-am654-memory-region-for-jailho.patch \
    file://0012-arm64-dts-disable-pcie0_rc-node-in-k3-am654-jailhous.patch \
    file://0013-arm64-dts-am625-base-board-Reserve-memory-for-jailho.patch \
    file://0014-arm64-dts-add-reserved_memory-label-for-CMA-regions-.patch \
"

KMETA = "kernel-meta"

include recipes-kernel/linux/linux-lmp.inc
