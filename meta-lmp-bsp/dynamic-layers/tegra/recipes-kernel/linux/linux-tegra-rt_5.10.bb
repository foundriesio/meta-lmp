require recipes-kernel/linux/linux-tegra_5.10.bb

# Use BSP with rt-patches applied
SRC_REPO = "github.com/foundriesio/linux.git;protocol=https"
SRCBRANCH = "oe4t-patches${LINUX_VERSION_EXTENSION}-rt"
SRCREV = "c757f64a928b5eefd47c99b398b9363ffd3c8d82"
