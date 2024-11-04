FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

include recipes-kernel/linux/kmeta-linux-lmp-${PV}.y.inc

KERNEL_REPO ?= "git://git.ti.com/git/ti-linux-kernel/ti-linux-kernel.git"
KERNEL_REPO_PROTOCOL ?= "https"
KERNEL_BRANCH ?= "ti-linux-6.6.y"

LINUX_VERSION ?= "6.6.44"
SRCREV_machine ?= "e3b431a6194fc1b074802d20c9eede8442382b2a"
SRCREV_meta ?= "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRC_URI = "${KERNEL_REPO};protocol=${KERNEL_REPO_PROTOCOL};branch=${KERNEL_BRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
"

KMETA = "kernel-meta"

include recipes-kernel/linux/linux-lmp.inc

# Special configuration for remoteproc/rpmsg IPC modules
module_conf_rpmsg_client_sample = "blacklist rpmsg_client_sample"
module_conf_ti_k3_r5_remoteproc = "softdep ti_k3_r5_remoteproc pre: virtio_rpmsg_bus"
module_conf_ti_k3_dsp_remoteproc = "softdep ti_k3_dsp_remoteproc pre: virtio_rpmsg_bus"
KERNEL_MODULE_PROBECONF += "rpmsg_client_sample ti_k3_r5_remoteproc ti_k3_dsp_remoteproc"

# not found in linux-lmp-ti-staging-6.6.44
# meta-ti-bsp/conf/machine/am62xx-evm.conf
# meta-ti-bsp/conf/machine/beagleplay.conf
KERNEL_DEVICETREE:remove:am62xx = " \
    ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtbo \
"

# not found in linux-lmp-ti-staging-6.6.44
# meta-ti-bsp/conf/machine/include/am64xx.inc
KERNEL_DEVICETREE:remove:am64xx = " \
    ti/k3-am642-hummingboard-t-pcie.dtbo \
    ti/k3-am642-hummingboard-t-usb3.dtbo \
    ti/k3-am642-hummingboard-t.dtb \
    ti/k3-am642-phyboard-electra-gpio-fan.dtbo \
    ti/k3-am642-phyboard-electra-pcie-usb2.dtbo \
"
