require recipes-kernel/linux/linux-tegra_5.10.bb

# Use BSP with rt-patches applied
SRC_REPO = "github.com/foundriesio/linux.git;protocol=https"
SRCBRANCH = "oe4t-patches${LINUX_VERSION_EXTENSION}-rt"
SRCREV = "d29919aa6013b9d6b291d60dbc637b8d3b66e0f4"
