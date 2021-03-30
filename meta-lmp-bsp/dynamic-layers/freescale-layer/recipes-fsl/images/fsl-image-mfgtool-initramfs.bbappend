# LMP specifics
IMAGE_FSTYPES_lmp = "cpio.gz"
DEPENDS_remove = "u-boot-mfgtool linux-mfgtool"
DEPENDS_append = " virtual/bootloader virtual/kernel"

inherit nopackages
