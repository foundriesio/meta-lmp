require recipes-kernel/linux/linux-tegra_5.10.bb

# Use BSP with rt-patches applied
SRC_REPO = "github.com/foundriesio/linux.git;protocol=https"
SRCBRANCH = "oe4t-patches${LINUX_VERSION_EXTENSION}-rt"
SRCREV = "69b5850ac37b190ef2c017c073fda6dbe3806e8a"
