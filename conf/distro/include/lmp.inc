DISTRO_VERSION = "17.10.1"

# These default to 'oecore' and 'nodistro'
SDK_NAME_PREFIX = "${DISTRO}"
SDK_VERSION = "${DISTRO_VERSION}"

TARGET_VENDOR = "-osf"

require conf/distro/include/arm-defaults.inc

GCCVERSION ?= "linaro-7.%"

# TODO: update default provider after list gets removed from local.conf
#PREFERRED_PROVIDER_virtual/kernel = "linux-osf"

# No need for x11 even for native
DISTRO_FEATURES_NATIVE_remove = "x11"
DISTRO_FEATURES_NATIVESDK_remove = "x11"

# TODO: review default distro features
DISTRO_FEATURES_append = " pam systemd virtualization"
DISTRO_FEATURES_remove = "3g sysvinit"
VIRTUAL-RUNTIME_init_manager = "systemd"
PACKAGECONFIG_append_pn-systemd = " resolved networkd"

# Avoid to duplicate the rootfs tarball by generating both tar.gz/tar.xz
IMAGE_FSTYPES_remove = "tar.gz"

INHERIT += "buildhistory"
INHERIT += "image-buildinfo"
BUILDHISTORY_COMMIT = "1"
