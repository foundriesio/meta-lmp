require recipes-kernel/linux/linux-tegra_5.10.bb

# Use BSP with rt-patches applied
SRC_REPO = "github.com/foundriesio/linux.git;protocol=https"
SRCBRANCH = "oe4t-patches${LINUX_VERSION_EXTENSION}-rt"
SRCREV = "67c02150135fd85fbe367f76c8fa508461bd7c70"
