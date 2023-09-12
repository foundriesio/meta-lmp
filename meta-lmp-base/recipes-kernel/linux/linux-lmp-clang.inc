# https://github.com/kraj/meta-clang#kernel-build-with-clang

TOOLCHAIN:forcevariable = "clang"

DEPENDS:append:toolchain-clang = " clang-cross-${TARGET_ARCH}"

# https://github.com/kraj/meta-clang/issues/856
KERNEL_CC:remove:toolchain-clang = "-fuse-ld=bfd"

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

python __anonymous() {
    kernel_vars = [
        ['KERNEL_CC', 'gcc', 'clang'],
        ['KERNEL_LD', 'ld.bfd', 'ld.lld'],
        ['KERNEL_AR', 'ar', 'llvm-ar'],
    ]
    for [var, match, rep] in kernel_vars:
        v = d.getVar(var, False)
        d.setVar(var , v.replace('${HOST_PREFIX}%s' % match, '${HOST_PREFIX}%s' % rep))
}
