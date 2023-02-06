BIF_OPTEE_ATTR      ??= "optee-os-fio"
BIF_PARTITION_ATTR  ??= "${BIF_FSBL_ATTR} ${BIF_DEVICETREE_ATTR} ${BIF_ATF_ATTR} ${BIF_SSBL_ATTR} ${BIF_OPTEE_ATTR}"

# specify BIF partition attributes for optee-os
BIF_PARTITION_ATTR[optee-os-fio] ?= "type=raw, load=0x60000000"
BIF_PARTITION_IMAGE[optee-os-fio] ?= "${RECIPE_SYSROOT}/usr/lib/firmware/tee-raw.bin"
BIF_PARTITION_ID[optee-os-fio] ?= "0x1c000000"
