FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

include recipes-kernel/linux/kmeta-linux-lmp-6.1.y.inc

KERNEL_REPO ?= "git://git.ti.com/git/ti-linux-kernel/ti-linux-kernel.git"
KERNEL_REPO_PROTOCOL ?= "https"
KERNEL_BRANCH ?= "ti-linux-6.1.y"

LINUX_VERSION ?= "6.1.69"
SRCREV_machine ?= "2233af66faf7b81b6c286285e50cda5595dc410d"
SRCREV_meta ?= "${KERNEL_META_COMMIT}"

# Beagleplay (has its own repo)
KERNEL_REPO:beagleplay ?= "git://github.com/beagleboard/linux.git"
KERNEL_BRANCH:beagleplay ?= "v6.1.46-ti-arm64-r13"
LINUX_VERSION:beagleplay ?= "6.1.46"
SRCREV_machine:beagleplay ?= "f47f74d11b19d8ae2f146de92c258f40e0930d86"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRC_URI = "${KERNEL_REPO};protocol=${KERNEL_REPO_PROTOCOL};branch=${KERNEL_BRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
    ${@bb.utils.contains('MACHINE_FEATURES', 'jailhouse', '${SRC_URI_JAILHOUSE}', '', d)} \
"

# Jailhouse patches and config
SRC_URI_JAILHOUSE = " \
    file://0001-uio-Enable-read-only-mappings.patch \
    file://0002-ivshmem-Add-header-file.patch \
    file://0003-uio-Add-driver-for-inter-VM-shared-memory-device.patch \
    file://0004-jailhouse-Add-simple-debug-console-via-the-hyperviso.patch \
    file://0005-Revert-arm-Remove-the-ability-to-set-HYP-vectors-out.patch \
    file://0006-arm-Export-__boot_cpu_mode-for-use-in-Jailhouse-driv.patch \
    file://0007-mm-Re-export-ioremap_page_range.patch \
    file://0008-Revert-mm-don-t-allow-executable-ioremap-mappings.patch \
    file://0009-mm-vmalloc-Export-__get_vm_area_caller.patch \
    file://0010-arm-arm64-export-__hyp_stub_vectors.patch \
    file://0011-x86-Export-lapic_timer_period.patch \
    file://0012-ivshmem-net-virtual-network-device-for-Jailhouse.patch \
    file://0013-arm64-dts-add-reserved_memory-label-for-CMA-regions-.patch \
    file://0014-arm64-dts-am625-base-board-Reserve-memory-for-jailho.patch \
    file://0015-arm64-dts-Makefile-Update-makefile-to-build-overlay.patch \
"

KMETA = "kernel-meta"

include recipes-kernel/linux/linux-lmp.inc

# Special configuration for remoteproc/rpmsg IPC modules
module_conf_rpmsg_client_sample = "blacklist rpmsg_client_sample"
module_conf_ti_k3_r5_remoteproc = "softdep ti_k3_r5_remoteproc pre: virtio_rpmsg_bus"
module_conf_ti_k3_dsp_remoteproc = "softdep ti_k3_dsp_remoteproc pre: virtio_rpmsg_bus"
KERNEL_MODULE_PROBECONF += "rpmsg_client_sample ti_k3_r5_remoteproc ti_k3_dsp_remoteproc"
