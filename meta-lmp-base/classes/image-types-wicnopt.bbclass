# This class removes the empty partition table header
# in the WIC file when --no-table WKS option is used
#
# Make sure to include 'wic.nopt' at IMAGE_TYPES for
# the desired target

CONVERSIONTYPES += "nopt"

# 1024 bytes are skipped which corresponds to the size of the partition table header to remove
CONVERSION_CMD:nopt = "tail -c +1025 ${IMAGE_NAME}.${type} > ${IMAGE_NAME}.${type}.nopt"
