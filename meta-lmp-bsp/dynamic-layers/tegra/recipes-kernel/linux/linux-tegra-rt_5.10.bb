require recipes-kernel/linux/linux-tegra_5.10.bb

# Use BSP with rt-patches applied
SRC_REPO = "github.com/foundriesio/linux.git;protocol=https"
SRCBRANCH = "oe4t-patches${LINUX_VERSION_EXTENSION}-rt"
SRCREV = "b445f96ee97e52cfb10f6121af771ed526ffb922"
