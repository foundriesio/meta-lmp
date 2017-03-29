require linux.inc

DESCRIPTION = "96boards-hikey kernel"

PV = "4.9+git${SRCPV}"
SRCREV_kernel = "04ec80a78dbc970cf921abc02910d2148cec6dbb"
SRCREV_FORMAT = "kernel"

SRC_URI = "git://github.com/Linaro/rpk.git;protocol=https;branch=master;name=kernel \
"

SRC_URI_append_hikey = " \
    http://malideveloper.arm.com/downloads/drivers/DX910/r6p0-01rel0/DX910-SW-99002-r6p0-01rel0.tgz;name=mali \
    file://defconfig;subdir=git/kernel/configs \
    file://mali-450.conf;subdir=git/kernel/configs \
    file://END_USER_LICENCE_AGREEMENT.txt;subdir=git \
    file://0001-linux-hikey-dts-add-mali-configuration-in-the-device.patch \
    file://0001-thermal-hisilicon-use-dev_dbg-when-bind-sensors.patch \
    file://0001-drivers-gpu-Add-ARM-Mali-Utgard-r6p0-driver.patch \
    file://0002-drivers-gpu-arm-utgard-add-option-for-custom-device-.patch \
    file://0003-drivers-gpu-arm-utgard-add-Hi6220-register-definitio.patch \
    file://0004-drivers-gpu-arm-utgard-add-basic-HiKey-platform-file.patch \
    file://0005-drivers-gpu-arm-utgard-Fix-build-issue.patch \
    file://0006-drivers-gpu-arm-utgard-Disable-fbdev-physical-addres.patch \
    file://0007-mali_hikey-Modify-irq-initialization-in-mali-hikey-p.patch \
    file://0008-gpu-mali-fix-get_unused_fd-build-issue.patch \
    file://0009-gpu-arm-fix-dma_ops-build-error.patch \
    file://0001-mali-dma-mapping-use-unsigned-long-for-dma_attrs.patch \
    file://0002-Mali-replace-page_cache_release-with-put_page.patch \
"

SRC_URI[mali.md5sum] = "49a03a4e765cfe5e87cccfdef97f9208"
SRC_URI[mali.sha256sum] = "15813d964cb9308c236a7c71f8e2d8f346b13fa8ff6c8b3bd7e521ef123c1254"

# Mali 400/450 GPU kernel device drivers license is GPLv2
LIC_FILES_CHKSUM_hikey = "file://END_USER_LICENCE_AGREEMENT.txt;md5=450d710cd9d21c5ea5c4ac4217362b7e"

S = "${WORKDIR}/git"

COMPATIBLE_MACHINE = "hikey"
KERNEL_IMAGETYPE ?= "Image"
KERNEL_CONFIG_FRAGMENTS_hikey += "${S}/kernel/configs/mali-450.conf"

# make[3]: *** [scripts/extract-cert] Error 1
DEPENDS += "openssl-native"
HOST_EXTRACFLAGS += "-I${STAGING_INCDIR_NATIVE}"

do_unpack_append_hikey() {
    bb.build.exec_func('do_unpack_mali_drv', d)
}

do_unpack_mali_drv() {
    mkdir -p ${S}/drivers/gpu/arm
    mv ${WORKDIR}/DX910-SW-99002-r6p0-01rel0/driver/src/devicedrv/mali \
       ${S}/drivers/gpu/arm/utgard
}

do_configure() {
    # Make sure to disable debug info and enable ext4fs built-in
    sed -e '/CONFIG_EXT4_FS=/d' \
        -e '/CONFIG_DEBUG_INFO=/d' \
        < ${S}/kernel/configs/defconfig \
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
