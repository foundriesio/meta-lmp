include recipes-kernel/linux/kmeta-linux-lmp-5.4.y.inc

LINUX_VERSION ?= "5.4.93"
KBRANCH = "ti-linux-5.4.y"
SRCREV_machine = "87c0425824b4169e4d697c4f6219243249a8c08b"
SRCREV_meta = "${KERNEL_META_COMMIT}"

TI_DEFCONFIG_BUILDER_TARGET ?= "ti_sdk_arm64_release"
KBUILD_DEFCONFIG ?= "${TI_DEFCONFIG_BUILDER_TARGET}_defconfig"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

# add device-tree to rootfs
RDEPENDS_${KERNEL_PACKAGE_NAME}-base_append_lmp-base = " kernel-devicetree"

SRC_URI = "git://git.ti.com/git/ti-linux-kernel/ti-linux-kernel.git;protocol=https;branch=${KBRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
    file://0001-FIO-fromtree-tee-add-support-for-session-s-client-UU.patch \
    file://0002-FIO-fromtree-tee-optee-Add-support-for-session-login.patch \
    file://0001-driver-tee-Handle-NULL-pointer-indication-from-clien.patch \
"

KMETA = "kernel-meta"

do_kernel_metadata_prepend() {
    cd ${S}
    ti_config_fragments/defconfig_builder.sh -t ${TI_DEFCONFIG_BUILDER_TARGET}
}

include recipes-kernel/linux/linux-lmp.inc
