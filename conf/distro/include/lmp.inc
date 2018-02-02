DISTRO_VERSION = "2.4"

# These default to 'oecore' and 'nodistro'
SDK_NAME_PREFIX = "${DISTRO}"
SDK_VERSION = "${DISTRO_VERSION}"

MAINTAINER = "OSF Support <support@opensourcefoundries.com>"

TARGET_VENDOR = "-osf"

TCLIBCAPPEND = ""

require conf/distro/include/arm-defaults.inc

PREFERRED_PROVIDER_virtual/kernel = "linux-osf"
PREFERRED_PROVIDER_iasl-native = "acpica-native"
PREFERRED_VERSION_grub ?= "2.02"

# No need for x11 even for native
DISTRO_FEATURES_NATIVE_remove = "x11"
DISTRO_FEATURES_NATIVESDK_remove = "x11"

# TODO: review default distro features
DISTRO_FEATURES_append = " pam systemd virtualization"
DISTRO_FEATURES_remove = "3g sysvinit"
VIRTUAL-RUNTIME_init_manager = "systemd"
PACKAGECONFIG_append_pn-systemd = " resolved networkd"
PACKAGECONFIG_append_pn-qemu-native = " libusb"

# Default image formats
IMAGE_FSTYPES_append = " tar.xz"
IMAGE_FSTYPES_remove = "tar.gz tar.bz2"

# LMP default classes and overwrites
INHERIT += "lmp"

INHERIT += "buildhistory"
INHERIT += "image-buildinfo"
BUILDHISTORY_COMMIT = "1"

PREMIRRORS ??= "\
     git://.*/.* https://lmp-mirror.foundries.io/downloads/ \n \
     ftp://.*/.* https://lmp-mirror.foundries.io/downloads/ \n \
     http://.*/.* https://lmp-mirror.foundries.io/downloads/ \n \
     https://.*/.* https://lmp-mirror.foundries.io/downloads/ \n \
"

MIRRORS =+ "\
     ftp://.*/.* https://lmp-mirror.foundries.io/downloads/ \n \
     http://.*/.* https://lmp-mirror.foundries.io/downloads/ \n \
     https://.*/.* https://lmp-mirror.foundries.io/downloads/ \n \
"
