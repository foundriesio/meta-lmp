require linux.inc

DESCRIPTION = "96boards-hikey kernel for HiKey960"

PV = "4.4+git${SRCPV}"
SRCREV_kernel = "ffbd0f9ccd7a1b6a64ff33deac8d7d746991072b"
SRCREV_FORMAT = "kernel"
SRCREV_tools = "939a59a3689f47322d02d46109567eb517eec8ff"

SRC_URI = "git://github.com/96boards-hikey/linux.git;protocol=https;branch=working-hikey960-1208-base-android;name=kernel \
    git://github.com/96boards-hikey/tools-images-hikey960.git;protocol=https;name=tools;destsuffix=tools-images-hikey960 \
"

S = "${WORKDIR}/git"

COMPATIBLE_MACHINE = "hikey960"
KERNEL_IMAGETYPE ?= "Image"

# make[3]: *** [scripts/extract-cert] Error 1
DEPENDS += "openssl-native"
HOST_EXTRACFLAGS += "-I${STAGING_INCDIR_NATIVE}"

do_configure() {
    # Make sure to disable debug info and enable ext4fs built-in
    sed -e '/CONFIG_EXT4_FS=/d' \
        -e '/CONFIG_DEBUG_INFO=/d' \
        < ${S}/arch/arm64/configs/defconfig \
        > ${B}/.config

    echo 'CONFIG_EXT4_FS=y' >> ${B}/.config
    echo '# CONFIG_DEBUG_INFO is not set' >> ${B}/.config

    # Check for kernel config fragments. The assumption is that the config
    # fragment will be specified with the absolute path. For example:
    #   * ${WORKDIR}/config1.cfg
    #   * ${S}/config2.cfg
    # Iterate through the list of configs and make sure that you can find
    # each one. If not then error out.
    # NOTE: If you want to override a configuration that is kept in the kernel
    #       with one from the OE meta data then you should make sure that the
    #       OE meta data version (i.e. ${WORKDIR}/config1.cfg) is listed
    #       after the in-kernel configuration fragment.
    # Check if any config fragments are specified.
    if [ ! -z "${KERNEL_CONFIG_FRAGMENTS}" ]; then
        for f in ${KERNEL_CONFIG_FRAGMENTS}; do
            # Check if the config fragment was copied into the WORKDIR from
            # the OE meta data
            if [ ! -e "$f" ]; then
                echo "Could not find kernel config fragment $f"
                exit 1
            fi
        done

        # Now that all the fragments are located merge them.
        ( cd ${WORKDIR} && ${S}/scripts/kconfig/merge_config.sh -m -r -O ${B} ${B}/.config ${KERNEL_CONFIG_FRAGMENTS} 1>&2 )
    fi

    yes '' | oe_runmake -C ${S} O=${B} oldconfig
}

# Exclude DATETIME for signatures to avoid invalidating them during a build
BOOT_IMAGE_BASE_NAME[vardepsexclude] = "DATETIME"
DT_IMAGE_BASE_NAME[vardepsexclude] = "DATETIME"

BOOT_IMAGE_BASE_NAME = "boot-${PKGV}-${PKGR}-${MACHINE}-${DATETIME}"
DT_IMAGE_BASE_NAME = "dt-${PKGV}-${PKGR}-${MACHINE}-${DATETIME}"

do_deploy_append() {
    # mkbootimg requires a ramdisk, make a dummy one
    touch ramdisk; echo ramdisk | cpio -vo > ${B}/ramdisk.img; rm -f ramdisk

    # Create boot image
    python ${WORKDIR}/tools-images-hikey960/mkbootimg \
      --kernel ${DEPLOYDIR}/${KERNEL_IMAGETYPE} \
      --ramdisk ${B}/ramdisk.img \
      --cmdline "${CMDLINE}" \
      --base 0x0 \
      --tags-addr 0x07A00000 \
      --kernel_offset 0x00080000 \
      --ramdisk_offset 0x07c00000 \
      --output ${DEPLOYDIR}/${BOOT_IMAGE_BASE_NAME}.img

    # Create device tree image
    python ${WORKDIR}/tools-images-hikey960/mkdtimg \
      --compress \
      --dtb ${DEPLOYDIR}/Image-hi3660-hikey960.dtb \
      --pagesize 2048 \
      --output ${DEPLOYDIR}/${DT_IMAGE_BASE_NAME}.img

    (cd ${DEPLOYDIR} && ln -sf ${BOOT_IMAGE_BASE_NAME}.img boot-${MACHINE}.img)
    (cd ${DEPLOYDIR} && ln -sf ${DT_IMAGE_BASE_NAME}.img dt-${MACHINE}.img)
}
