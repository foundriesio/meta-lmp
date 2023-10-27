FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

include recipes-kernel/linux/kmeta-linux-lmp-6.1.y.inc

LINUX_VERSION ?= "6.1.33"
KBRANCH = "ti-linux-6.1.y"
SRCREV_machine = "8f7f371be250809e9c4af879cfa31d5f1839257d"
SRCREV_meta = "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRC_URI = "git://git.ti.com/ti-linux-kernel/ti-linux-kernel.git;protocol=git;branch=${KBRANCH};name=machine; \
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
