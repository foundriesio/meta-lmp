FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Disable PTEST for ostree as it requires options that are not enabled when
# building with meta-updater and meta-lmp.
PTEST_ENABLED = "0"

SRC_URI:append = " \
    file://0001-Allow-updating-files-in-the-boot-directory.patch \
    file://0002-u-boot-add-bootdir-to-the-generated-uEnv.txt.patch \
    file://0003-Add-support-for-directories-instead-of-symbolic-link.patch \
    file://0004-Add-support-for-systemd-boot-bootloader.patch \
    file://0005-ostree-decrease-default-grub.cfg-timeout-and-set-def.patch \
"

# glibc is built with gcc and hence encodes some libgcc specific builtins which are not found
# when doing static linking with clang using compiler-rt, so use libgcc
# undefined reference to `__unordtf2'
# | tmp-lmp/work/corei7-64-lmp-linux/ostree/2021.6-r0/recipe-sysroot-native/usr/bin/x86_64-lmp-linux/x86_64-lmp-linux-ld: tmp-lmp/work/corei7-64-lmp-linux/ostree/2021.6-r0/recipe-sysroot//usr/lib/libc.a(printf_fp.o): in function `__printf_fp_l':
# | /usr/src/debug/glibc/2.35-r0/git/stdio-common/printf_fp.c:388: undefined reference to `__unordtf2'
# | tmp-lmp/work/corei7-64-lmp-linux/ostree/2021.6-r0/recipe-sysroot-native/usr/bin/x86_64-lmp-linux/x86_64-lmp-linux-ld: /usr/src/debug/glibc/2.35-r0/git/stdio-common/printf_fp.c:388: undefined reference to `__unordtf2'
# | tmp-lmp/work/corei7-64-lmp-linux/ostree/2021.6-r0/recipe-sysroot-native/usr/bin/x86_64-lmp-linux/x86_64-lmp-linux-ld: /usr/src/debug/glibc/2.35-r0/git/stdio-common/printf_fp.c:388: undefined reference to `__letf2'
# | tmp-lmp/work/corei7-64-lmp-linux/ostree/2021.6-r0/recipe-sysroot-native/usr/bin/x86_64-lmp-linux/x86_64-lmp-linux-ld: tmp-lmp/work/corei7-64-lmp-linux/ostree/2021.6-r0/recipe-sysroot//usr/lib/libc.a(printf_fphex.o): in function `__printf_fphex':
# | /usr/src/debug/glibc/2.35-r0/git/stdio-common/../stdio-common/printf_fphex.c:206: undefined reference to `__unordtf2'
# | tmp-lmp/work/corei7-64-lmp-linux/ostree/2021.6-r0/recipe-sysroot-native/usr/bin/x86_64-lmp-linux/x86_64-lmp-linux-ld: /usr/src/debug/glibc/2.35-r0/git/stdio-common/../stdio-common/printf_fphex.c:206: undefined reference to `__unordtf2'
# | tmp-lmp/work/corei7-64-lmp-linux/ostree/2021.6-r0/recipe-sysroot-native/usr/bin/x86_64-lmp-linux/x86_64-lmp-linux-ld: /usr/src/debug/glibc/2.35-r0/git/stdio-common/../stdio-common/printf_fphex.c:206: undefined reference to `__letf2'
# | x86_64-lmp-linux-clang -target x86_64-lmp-linux  -m64 -march=nehalem -mtune=generic -mfpmath=sse -msse4.2 -mlittle-endian --dyld-prefix=/usr -Qunused-arguments -fstack-protector-strong  -O2 -D_F
COMPILER_RT:libc-glibc:toolchain-clang:x86 = " \
    ${@bb.utils.contains('PACKAGECONFIG', 'static', '-rtlib=libgcc --unwindlib=libgcc', '', d)}"
COMPILER_RT:libc-glibc:toolchain-clang:x86-64 = " \
    ${@bb.utils.contains('PACKAGECONFIG', 'static', '-rtlib=libgcc --unwindlib=libgcc', '', d)}"
