# LMP specifics
IMAGE_FSTYPES:lmp = "cpio.gz"
DEPENDS:remove = "u-boot-mfgtool linux-mfgtool"
DEPENDS:append = " virtual/bootloader virtual/kernel"

inherit nopackages
