# https://github.com/kraj/meta-clang#kernel-build-with-clang

TOOLCHAIN:forcevariable = "clang"

DEPENDS:append:toolchain-clang = " clang-cross-${TARGET_ARCH}"
KERNEL_CC:toolchain-clang = "${CCACHE}clang ${HOST_CC_KERNEL_ARCH} ${DEBUG_PREFIX_MAP} -fdebug-prefix-map=${STAGING_KERNEL_DIR}=${KERNEL_SRC_PATH}"
KERNEL_LD:toolchain-clang = "${CCACHE}ld.lld"
KERNEL_AR:toolchain-clang = "${CCACHE}llvm-ar"

# FIXME: hacks
do_kernel_configcheck[noexec] = "1"

# error: taking address of packed member 'xxx' of class or structure 'yyy' may result in an unaligned pointer value [-Werror,-Waddress-of-packed-member]
# because kernel don't use CFLAGS we need to pass it over EXTRA_OEMAKE
EXTRA_OEMAKE += 'CFLAGS="-Wno-address-of-packed-member"'

# explicitly enable LLVM
# https://docs.kernel.org/kbuild/llvm.html
KERNEL_EXTRA_ARGS += "LLVM=1"

# verbose build
#KERNEL_EXTRA_ARGS += "V=1"

# disable pararel make
#PARALLEL_MAKE = "-j1"
