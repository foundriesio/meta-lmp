include recipes-kernel/linux/kmeta-linux-lmp-5.10.y.inc

LINUX_VERSION ?= "5.10.41"
KBRANCH = "ti-linux-5.10.y"
SRCREV_machine = "4c2eade9f722838b0e457650368cba1c6c7483c2"
SRCREV_meta = "${KERNEL_META_COMMIT}"

TI_DEFCONFIG_BUILDER_TARGET ?= "ti_sdk_arm64_release"
KBUILD_DEFCONFIG ?= "${TI_DEFCONFIG_BUILDER_TARGET}_defconfig"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

# add device-tree to rootfs
RDEPENDS_${KERNEL_PACKAGE_NAME}-base_append_lmp-base = " kernel-devicetree"

SRC_URI = "git://git.ti.com/ti-linux-kernel/ti-linux-kernel.git;protocol=git;branch=${KBRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
"

SRC_URI_append_am64xx-evm = " \
    file://0001-arm64-dts-ti-k3-am642-sk-Enable-WLAN-connected-to-SD.patch \
"

KMETA = "kernel-meta"

do_kernel_metadata_prepend() {
    cd ${S}
    ti_config_fragments/defconfig_builder.sh -t ${TI_DEFCONFIG_BUILDER_TARGET}
}

include recipes-kernel/linux/linux-lmp.inc
