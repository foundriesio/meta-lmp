# Required to make it compatible with tegraflash
## Once cboot can be optional we can drop these changes
IMAGE_FSTYPES:append:tegra = " cpio.gz.cboot cpio.gz.cboot.bup-payload"
IMAGE_FSTYPES:remove:tegra = "tegraflash"
