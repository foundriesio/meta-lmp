DESCRIPTION = "Common Open Source Foundries Linux microPlatform Kernel"
SECTION = "kernel"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"

PV = "${LINUX_VERSION}+git${SRCPV}"

DEPENDS += "${@bb.utils.contains('ARCH', 'x86', 'elfutils-native', '', d)}"
DEPENDS += "openssl-native util-linux-native"

inherit kernel siteinfo
require recipes-kernel/linux/linux-yocto.inc

KCONFIG_MODE = "--alldefconfig"

# You can define CMDLINE_DEBUG as "debug" in your local.conf or distro.conf
# to enable kernel debugging.
CMDLINE_DEBUG ?= ""
CMDLINE_append = " ${CMDLINE_DEBUG}"

KERNEL_INITRAMFS ?= '${@base_conditional("INITRAMFS_IMAGE_BUNDLE", "1", "1", "", d)}'

# Always have a package to allow forcing package dependency
ALLOW_EMPTY_${KERNEL_PACKAGE_NAME}-devicetree = "1"

python __anonymous () {
    import bb
    devicetree = d.getVar('KERNEL_DEVICETREE', True) or ''
    if devicetree:
        depends = d.getVar("DEPENDS", True)
        d.setVar("DEPENDS", "%s dtc-native" % depends)
}

# Set a variable in .configure
# $1 - Configure variable to be set
# $2 - value [n/y/value]
kernel_configure_variable() {
    # Remove the config
    CONF_SED_SCRIPT="$CONF_SED_SCRIPT /CONFIG_$1[ =]/d;"
    if test "$2" = "n"
    then
        echo "# CONFIG_$1 is not set" >> ${B}/.config
    else
        echo "CONFIG_$1=$2" >> ${B}/.config
    fi
}

do_configure_prepend() {
    mv -f ${B}/.config ${B}/.config.patched
    CONF_SED_SCRIPT=""

    # Set cmdline
    kernel_configure_variable CMDLINE "\"${CMDLINE}\""

    # Localversion
    kernel_configure_variable LOCALVERSION "\"\""
    kernel_configure_variable LOCALVERSION_AUTO n

    # Udev quirks
    # Newer versions of udev mandate that sysfs doesn't have deprecated entries
    kernel_configure_variable SYSFS_DEPRECATED n
    kernel_configure_variable SYSFS_DEPRECATED_V2 n
    kernel_configure_variable HOTPLUG y
    kernel_configure_variable UEVENT_HELPER_PATH "\"\""
    kernel_configure_variable UNIX y
    kernel_configure_variable SYSFS y
    kernel_configure_variable PROC_FS y
    kernel_configure_variable TMPFS y
    kernel_configure_variable INOTIFY_USER y
    kernel_configure_variable SIGNALFD y
    kernel_configure_variable TMPFS_POSIX_ACL y
    kernel_configure_variable BLK_DEV_BSG y
    kernel_configure_variable DEVTMPFS y
    kernel_configure_variable DEVTMPFS_MOUNT y

    # Systemd need cgroup support
    kernel_configure_variable CGROUP_SCHED y
    kernel_configure_variable CGROUPS y
    kernel_configure_variable CGROUP_NS y
    kernel_configure_variable CGROUP_FREEZER y
    kernel_configure_variable CGROUP_DEVICE y
    kernel_configure_variable CPUSETS y
    kernel_configure_variable PROC_PID_CPUSET y
    kernel_configure_variable CGROUP_CPUACCT y
    kernel_configure_variable RESOURCE_COUNTERS y

    # Systemd
    kernel_configure_variable RT_GROUP_SCHED n

    # root-over-nfs-over-usb-eth support. Limited, but should cover some cases
    # Enable this by setting a proper CMDLINE_NFSROOT_USB.
    if [ ! -z "${CMDLINE_NFSROOT_USB}" ]; then
        oenote "Configuring the kernel for root-over-nfs-over-usb-eth with CMDLINE ${CMDLINE_NFSROOT_USB}"
        kernel_configure_variable INET y
        kernel_configure_variable IP_PNP y
        kernel_configure_variable USB_GADGET y
        kernel_configure_variable USB_GADGET_SELECTED y
        kernel_configure_variable USB_ETH y
        kernel_configure_variable NFS_FS y
        kernel_configure_variable ROOT_NFS y
        kernel_configure_variable ROOT_NFS y
        kernel_configure_variable CMDLINE "\"${CMDLINE_NFSROOT_USB}\""
    fi

    if [ ! -z "${KERNEL_INITRAMFS}" ]; then
        kernel_configure_variable BLK_DEV_INITRD y
        kernel_configure_variable INITRAMFS_SOURCE ""
        kernel_configure_variable RD_GZIP y
        kernel_configure_variable OVERLAY_FS y
        kernel_configure_variable SQUASHFS y
        kernel_configure_variable UBIFS_FS y
    fi

    # Activate CONFIG_LEGACY_PTYS
    kernel_configure_variable LEGACY_PTYS y
    # this module is built externally via drbd-utils
    kernel_configure_variable BLK_DEV_DRBD n

    # Activate the configuration options for VC4
    VC4GRAPHICS="${@bb.utils.contains("MACHINE_FEATURES", "vc4graphics", "1", "0", d)}"
    if [ ${VC4GRAPHICS} = "1" ]; then
        kernel_configure_variable I2C_BCM2835 y
        kernel_configure_variable DRM y
        kernel_configure_variable DRM_FBDEV_EMULATION y
        kernel_configure_variable DRM_VC4 y
    fi

    # Keep this the last line
    # Remove all modified configs and add the rest to .config
    sed -e "${CONF_SED_SCRIPT}" < '${B}/.config.patched' >> '${B}/.config'
    rm -f ${B}/.config.patched

    yes '' | oe_runmake oldconfig
    bbplain "Saving defconfig to:\n${B}/defconfig"
    oe_runmake -C ${B} savedefconfig
}

do_install_append() {
    install -d ${D}/boot
    make -C ${S} O=${B} ARCH=$ARCH dtbs || true
    install -m 0644 ${B}/arch/$ARCH/boot/dts/*.dtb ${D}/boot || true

    # Workaround for http://lists.openembedded.org/pipermail/openembedded-core/2018-January/146214.html
    for type in ${KERNEL_IMAGETYPES} ; do
            install -m 0644 ${KERNEL_OUTPUT_DIR}/${type} ${D}/${KERNEL_IMAGEDEST}/${type}-${KERNEL_VERSION}
            if [ "${KERNEL_PACKAGE_NAME}" = "kernel" ]; then
                    ln -sf ${type}-${KERNEL_VERSION} ${D}/${KERNEL_IMAGEDEST}/${type}
            fi
    done
}

do_deploy_append() {
    cp -a ${B}/defconfig ${DEPLOYDIR}
    cp -a ${B}/.config ${DEPLOYDIR}/config
}

PACKAGES =+ "${KERNEL_PACKAGE_NAME}-devicetree-overlays"
FILES_${KERNEL_PACKAGE_NAME}-devicetree-overlays = "/lib/firmware/*.dtbo /lib/firmware/*.dts"
FILES_${KERNEL_PACKAGE_NAME}-devicetree += "/boot/*.dtb"

RDEPENDS_${KERNEL_PACKAGE_NAME}-image_append = " ${KERNEL_PACKAGE_NAME}-devicetree"
RRECOMMENDS_${KERNEL_PACKAGE_NAME}-image_append = " ${KERNEL_PACKAGE_NAME}-devicetree-overlays"
