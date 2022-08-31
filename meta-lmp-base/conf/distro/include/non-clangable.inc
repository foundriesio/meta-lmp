
# Depend on GNU objcopy option missing in llvm-objcopy
# | [39/1637] /build/tmp-lmp/work/cortexa53-crypto-lmp-linux/systemd/1_250.5-r0/recipe-sysroot-native/usr/bin/aarch64-lmp-linux/aarch64-lmp-linux-llvm-objcopy -j '.bss*' -j .data -j .dynamic -j .dynsym -j .osrel -j '.rel*' -j .sbat -j .sdata -j .sdmagic -j .text --section-alignment=512 -O binary src/boot/efi/linuxaa64.elf.stub src/boot/efi/linuxaa64.efi.stub
# | FAILED: src/boot/efi/linuxaa64.efi.stub
# | /build/tmp-lmp/work/cortexa53-crypto-lmp-linux/systemd/1_250.5-r0/recipe-sysroot-native/usr/bin/aarch64-lmp-linux/aarch64-lmp-linux-llvm-objcopy -j '.bss*' -j .data -j .dynamic -j .dynsym -j .osrel -j '.rel*' -j .sbat -j .sdata -j .sdmagic -j .text --section-alignment=512 -O binary src/boot/efi/linuxaa64.elf.stub src/boot/efi/linuxaa64.efi.stub
# | /build/tmp-lmp/work/cortexa53-crypto-lmp-linux/systemd/1_250.5-r0/recipe-sysroot-native/usr/bin/aarch64-lmp-linux/aarch64-lmp-linux-llvm-objcopy: error: unknown argument '--section-alignment=512'
OBJCOPY:pn-systemd:toolchain-clang = "${HOST_PREFIX}objcopy"

# glibc is built with gcc and hence encodes some libgcc specific builtins which are not found
# when doing static linking with clang using compiler-rt, so use libgcc
# undefined reference to `__unordtf2'
# | /srv/oe/build/tmp-lmp/work/corei7-64-lmp-linux/tini/0.19.0-r0/recipe-sysroot-native/usr/bin/x86_64-lmp-linux/x86_64-lmp-linux-ld: /usr/src/debug>
# | /srv/oe/build/tmp-lmp/work/corei7-64-lmp-linux/tini/0.19.0-r0/recipe-sysroot-native/usr/bin/x86_64-lmp-linux/x86_64-lmp-linux-ld: /usr/src/debug>
# ERROR: Task (/srv/oe/build/conf/../../layers/meta-virtualization/recipes-containers/tini/tini_0.19.0.bb:do_compile) failed with exit code '1'
COMPILER_RT:pn-tini:toolchain-clang:x86 = "-rtlib=libgcc --unwindlib=libgcc"
COMPILER_RT:pn-tini:toolchain-clang:x86-64 = "-rtlib=libgcc --unwindlib=libgcc"

# ERROR: tini-0.19.0-r0 do_package: Fatal errors occurred in subprocesses:
# Command '['x86_64-lmp-linux-llvm-objcopy', '--only-keep-debug', '/srv/oe/build/tmp-lmp/work/corei7-64-lmp-linux/tini/0.19.0-r0/package/usr/bin/docker-init', '/srv/oe/build/tmp-lmp/work/corei7-64-lmp-linux/tini/0.19.0-r0/package/usr/bin/.debug/docker-init']' returned non-zero exit status 1.
# Subprocess output:x86_64-lmp-linux-llvm-objcopy: error: Link field value 35 in section .rela.plt is not a symbol table
# ERROR: Task (/srv/oe/build/conf/../../layers/meta-virtualization/recipes-containers/tini/tini_0.19.0.bb:do_package) failed with exit code '1'
OBJCOPY:pn-tini:toolchain-clang = "${HOST_PREFIX}objcopy"

# ERROR: tini-0.19.0-r0 do_package: Fatal errors occurred in subprocesses:
# Command '['x86_64-lmp-linux-llvm-strip', '--remove-section=.comment', '--remove-section=.note', '/srv/oe/build/tmp-lmp/work/corei7-64-lmp-linux/tini/0.19.0-r0/package/usr/bin/docker-init']' returned non-zero exit status 1.
# Subprocess output:x86_64-lmp-linux-llvm-strip: error: Link field value 36 in section .rela.plt is not a symbol table
# ERROR: Task (/srv/oe/build/conf/../../layers/meta-virtualization/recipes-containers/tini/tini_0.19.0.bb:do_package) failed with exit code '1'
STRIP:pn-tini:toolchain-clang = "${HOST_PREFIX}strip"

# ERROR: ostree-2021.6-r0 do_populate_sysroot: Fatal errors occurred in subprocesses:
# Command '['x86_64-lmp-linux-llvm-strip', '--remove-section=.comment', '--remove-section=.note', '/srv/oe/build/tmp-lmp/work/corei7-64-lmp-linux/ostree/2021.6-r0/sysroot-destdir/usr/lib/ostree/ostree-prepare-root']' returned non-zero exit status 1.
# Subprocess output:x86_64-lmp-linux-llvm-strip: error: Link field value 35 in section .rela.plt is not a symbol table
# ERROR: Task (/srv/oe/build/conf/../../layers/meta-openembedded/meta-oe/recipes-extended/ostree/ostree_2021.6.bb:do_populate_sysroot) failed with exit code '1'
STRIP:pn-ostree:toolchain-clang = "${HOST_PREFIX}strip"

# ERROR: ostree-2021.6-r0 do_package: Fatal errors occurred in subprocesses:
# Command '['x86_64-lmp-linux-llvm-objcopy', '--only-keep-debug', '/srv/oe/build/tmp-lmp/work/corei7-64-lmp-linux/ostree/2021.6-r0/package/usr/lib/ostree/ostree-prepare-root', '/srv/oe/build/tmp-lmp/work/corei7-64-lmp-linux/ostree/2021.6-r0/package/usr/lib/ostree/.debug/ostree-prepare-root']' returned non-zero exit status 1.
# Subprocess output:x86_64-lmp-linux-llvm-objcopy: error: Link field value 35 in section .rela.plt is not a symbol table
# ERROR: Task (/srv/oe/build/conf/../../layers/meta-openembedded/meta-oe/recipes-extended/ostree/ostree_2021.6.bb:do_package) failed with exit code '1
OBJCOPY:pn-ostree:toolchain-clang = "${HOST_PREFIX}objcopy"

# ERROR: containerd-opencontainers-v1.5.11+gitAUTOINC+3df54a8523-r0 do_package: Fatal errors occurred in subprocesses:
# Command '['x86_64-lmp-linux-llvm-strip', '--remove-section=.comment', '--remove-section=.note', '/srv/oe/build/tmp-lmp/work/corei7-64-lmp-linux/containerd-opencontainers/v1.5.11+gitAUTOINC+3df54a8523-r0/package/usr/bin/containerd-shim']' returned non-zero exit status 1.
# Subprocess output:x86_64-lmp-linux-llvm-strip: error: SHT_STRTAB string table section [index 3] is non-null terminated
# Command '['x86_64-lmp-linux-llvm-strip', '--remove-section=.comment', '--remove-section=.note', '/srv/oe/build/tmp-lmp/work/corei7-64-lmp-linux/containerd-opencontainers/v1.5.11+gitAUTOINC+3df54a8523-r0/package/usr/bin/containerd-shim-runc-v1']' returned non-zero exit status 1.
# Subprocess output:x86_64-lmp-linux-llvm-strip: error: SHT_STRTAB string table section [index 9] is non-null terminated
# Command '['x86_64-lmp-linux-llvm-strip', '--remove-section=.comment', '--remove-section=.note', '/srv/oe/build/tmp-lmp/work/corei7-64-lmp-linux/containerd-opencontainers/v1.5.11+gitAUTOINC+3df54a8523-r0/package/usr/bin/containerd-shim-runc-v2']' returned non-zero exit status 1.
# Subprocess output:x86_64-lmp-linux-llvm-strip: error: SHT_STRTAB string table section [index 9] is non-null terminated
# Command '['x86_64-lmp-linux-llvm-strip', '--remove-section=.comment', '--remove-section=.note', '/srv/oe/build/tmp-lmp/work/corei7-64-lmp-linux/containerd-opencontainers/v1.5.11+gitAUTOINC+3df54a8523-r0/package/usr/bin/containerd-ctr']' returned non-zero exit status 1.
# Subprocess output:x86_64-lmp-linux-llvm-strip: error: SHT_STRTAB string table section [index 7] is non-null terminated
# ERROR: Task (/srv/oe/build/conf/../../layers/meta-lmp/meta-lmp-base/recipes-containers/containerd/containerd-opencontainers_git.bb:do_package) failed with exit code '1'
STRIP:pn-containerd-opencontainers:toolchain-clang = "${HOST_PREFIX}strip"
OBJCOPY:pn-containerd-opencontainers:toolchain-clang = "${HOST_PREFIX}objcopy"

# ERROR: docker-ce-20.10.14-ce+git87a90dc786bda134c9eb02adbae2c6a7342fb7f6-r0 do_package: Fatal errors occurred in subprocesses:
# Command '['x86_64-lmp-linux-llvm-strip', '--remove-section=.comment', '--remove-section=.note', '/srv/oe/build/tmp-lmp/work/corei7-64-lmp-linux/docker-ce/20.10.14-ce+git87a90dc786bda134c9eb02adbae2c6a7342fb7f6-r0/package/usr/bin/docker-proxy']' returned non-zero exit status 1.
# Subprocess output:x86_64-lmp-linux-llvm-strip: error: SHT_STRTAB string table section [index 7] is non-null terminated
# ERROR: Task (/srv/oe/build/conf/../../layers/meta-lmp/meta-lmp-base/recipes-containers/docker/docker-ce_git.bb:do_package) failed with exit code '1'
STRIP:pn-docker-ce:toolchain-clang = "${HOST_PREFIX}strip"
OBJCOPY:pn-docker-ce:toolchain-clang = "${HOST_PREFIX}objcopy"

# ERROR: docker-compose-2.6.0-r0 do_package: Fatal errors occurred in subprocesses:
# Command '['x86_64-lmp-linux-llvm-strip', '--remove-section=.comment', '--remove-section=.note', '/srv/oe/build/tmp-lmp/work/corei7-64-lmp-linux/docker-compose/2.6.0-r0/package/usr/lib/docker/cli-plugins/docker-compose']' returned non-zero exit status 1.3
# Subprocess output:x86_64-lmp-linux-llvm-strip: error: SHT_STRTAB string table section [index 7] is non-null terminated
# ERROR: Task (/srv/oe/build/conf/../../layers/meta-lmp/meta-lmp-base/recipes-containers/docker-compose/docker-compose_2.6.0.bb:do_package) failed wit
STRIP:pn-docker-compose:toolchain-clang = "${HOST_PREFIX}strip"
OBJCOPY:pn-docker-compose:toolchain-clang = "${HOST_PREFIX}objcopy"

# qemuarm64-secureboot
# | ld.lld: error: cannot open /usr/lib/clang/14.0.3/lib/linux/libclang_rt.builtins-aarch64.a: No such file or directory
#  /srv/oe/build/conf/../../layers/meta-lmp/meta-lmp-base/recipes-security/optee/optee-os-fio_3.17.0.bb:do_compile
#  /srv/oe/build/conf/../../layers/meta-lmp/meta-lmp-base/recipes-security/optee/optee-os-tadevkit_3.17.0.bb:do_compile
#  /srv/oe/build/conf/../../layers/meta-lmp/meta-lmp-base/recipes-security/optee/optee-test_3.17.0.bb:do_compile
TOOLCHAIN:pn-optee-os-fio = "gcc"
TOOLCHAIN:pn-optee-os-tadevkit = "gcc"
TOOLCHAIN:pn-optee-test = "gcc"

# apalis-imx6-sec
# imx8mm-lpddr4-evk-sec
# imx8mp-lpddr4-evk-sec
# uz3eg-iocc-ebbr-sec
#  /srv/oe/build/conf/../../layers/meta-lmp/meta-lmp-base/recipes-security/optee/optee-fiovb_git.bb:do_compile
TOOLCHAIN:pn-optee-fiovb = "gcc"

# kv260
# vck190-versal
# uz3eg-iocc-ebbr-sec
TOOLCHAIN:pn-arm-trusted-firmware = "gcc"

# am64xx-evm
TOOLCHAIN:pn-ti-sci-fw = "gcc"
TOOLCHAIN:pn-trusted-firmware-a = "gcc"

# jetson-agx-xavier-devkit
TOOLCHAIN:pn-cboot-t19x = "gcc"

# stm32mp1-disco
TOOLCHAIN:pn-tf-a-stm32mp = "gcc"

# qemuriscv64
TOOLCHAIN:pn-opensbi = "gcc"

# https://reviews.llvm.org/D34796
# | clang-14: error: unknown argument: '-fno-toplevel-reorder'
# | clang-14: warning: optimization flag '-fno-merge-constants' is not supported [-Wignored-optimization-argument]
TOOLCHAIN:pn-efitools = "gcc"

# side efect of https://reviews.llvm.org/D53608
# | configure: error: libmpfr not found or uses a different ABI (including static vs shared).
# | NOTE: The following config.log files may provide further information.
# | NOTE: /srv/oe/build/tmp-lmp/work/corei7-64-lmp-linux/libmpc/1.2.1-r0/build/config.log
# | ERROR: configure failed
# debug:
# !/srv/oe/build/tmp-lmp/work/corei7-64-lmp-linux/libmpc/1.2.1-r0/recipe-sysroot-native/usr/bin/x86_64-lmp-linux/x86_64-lmp-linux-ld: /srv/oe/build/tmp-lmp/work/corei7-64-lmp-linux/libmpc/1.2.1-r0/recipe-sysroot//usr/lib/libmpfr.so: undefined reference to `__extendxftf2'
# |/srv/oe/build/tmp-lmp/work/corei7-64-lmp-linux/libmpc/1.2.1-r0/recipe-sysroot-native/usr/bin/x86_64-lmp-linux/x86_64-lmp-linux-ld: /srv/oe/build/tmp-lmp/work/corei7-64-lmp-linux/libmpc/1.2.1-r0/recipe-sysroot//usr/lib/libmpfr.so: undefined reference to `__trunctfxf2'
TOOLCHAIN:pn-mpfr:x86 = "gcc"
TOOLCHAIN:pn-mpfr:x86-64 = "gcc"
