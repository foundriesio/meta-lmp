
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

# ERROR: mcumgr-v0.0.1+git-r0 do_package: Fatal errors occurred in subprocesses:
# Command '['x86_64-lmp-linux-llvm-strip', '--remove-section=.comment', '--remove-section=.note', '/srv/oe/build/tmp-lmp/work/corei7-64-lmp-linux/mcumgr/v0.0.1+git-r0/package/usr/bin/mcumgr']' returned non-zero exit status 1.
# Subprocess output:x86_64-lmp-linux-llvm-strip: error: SHT_STRTAB string table section [index 9] is non-null terminated
# ERROR: Task (/srv/oe/build/conf/../../layers/meta-lmp/meta-lmp-base/recipes-devtools/mcumgr/mcumgr_git.bb:do_package) failed with exit code '1'
STRIP:pn-mcumgr:toolchain-clang = "${HOST_PREFIX}strip"
OBJCOPY:pn-mcumgr:toolchain-clang = "${HOST_PREFIX}objcopy"

# meta-clang:kirkstone: clang is not ready to be used for linux kernel:
# commit 299a5fd ("linux-yocto: Use binutils provided strip")
# We have to remove using clang tools objcopy and strip for all LmP linux
# kernel recipes to avoid building errors like:
# aarch64-lmp-linux-llvm-strip: error: Link field value 30 in section .rela.dyn is not a symbol table
# do_assemble_fitimage.520200: 841: arm-lmp-linux-gnueabi-llvm-objcopy: not found
OBJCOPY:pn-linux-lmp-dev-mfgtool:toolchain-clang = "${HOST_PREFIX}objcopy"
STRIP:pn-linux-lmp-dev-mfgtool:toolchain-clang = "${HOST_PREFIX}strip"
OBJCOPY:pn-linux-lmp-rt:toolchain-clang = "${HOST_PREFIX}objcopy"
STRIP:pn-linux-lmp-rt:toolchain-clang = "${HOST_PREFIX}strip"
OBJCOPY:pn-linux-lmp:toolchain-clang = "${HOST_PREFIX}objcopy"
STRIP:pn-linux-lmp:toolchain-clang = "${HOST_PREFIX}strip"
OBJCOPY:pn-linux-lmp-dev:toolchain-clang = "${HOST_PREFIX}objcopy"
STRIP:pn-linux-lmp-dev:toolchain-clang = "${HOST_PREFIX}strip"
OBJCOPY:pn-linux-lmp-ea-imx:toolchain-clang = "${HOST_PREFIX}objcopy"
STRIP:pn-linux-lmp-ea-imx:toolchain-clang = "${HOST_PREFIX}strip"
OBJCOPY:pn-linux-lmp-rpi:toolchain-clang = "${HOST_PREFIX}objcopy"
STRIP:pn-linux-lmp-rpi:toolchain-clang = "${HOST_PREFIX}strip"
OBJCOPY:pn-linux-lmp-xlnx:toolchain-clang = "${HOST_PREFIX}objcopy"
STRIP:pn-linux-lmp-xlnx:toolchain-clang = "${HOST_PREFIX}strip"
OBJCOPY:pn-linux-lmp-toradex-imx:toolchain-clang = "${HOST_PREFIX}objcopy"
STRIP:pn-linux-lmp-toradex-imx:toolchain-clang = "${HOST_PREFIX}strip"
OBJCOPY:pn-linux-lmp-fslc-imx:toolchain-clang = "${HOST_PREFIX}objcopy"
STRIP:pn-linux-lmp-fslc-imx:toolchain-clang = "${HOST_PREFIX}strip"
OBJCOPY:pn-linux-lmp-fslc-imx-rt:toolchain-clang = "${HOST_PREFIX}objcopy"
STRIP:pn-linux-lmp-fslc-imx-rt:toolchain-clang = "${HOST_PREFIX}strip"
OBJCOPY:pn-linux-lmp-fslc-imx-xeno4:toolchain-clang = "${HOST_PREFIX}objcopy"
STRIP:pn-linux-lmp-fslc-imx-xeno4:toolchain-clang = "${HOST_PREFIX}strip"
OBJCOPY:pn-linux-lmp-ti-staging:toolchain-clang = "${HOST_PREFIX}objcopy"
STRIP:pn-linux-lmp-ti-staging:toolchain-clang = "${HOST_PREFIX}strip"
OBJCOPY:pn-linux-tegra:toolchain-clang = "${HOST_PREFIX}objcopy"
STRIP:pn-linux-tegra:toolchain-clang = "${HOST_PREFIX}strip"
OBJCOPY:pn-linux-tegra-rt:toolchain-clang = "${HOST_PREFIX}objcopy"
STRIP:pn-linux-tegra-rt:toolchain-clang = "${HOST_PREFIX}strip"

# jailhouse (includes kernel module)
# | warning: the compiler differs from the one used to build the kernel
TOOLCHAIN:pn-jailhouse = "gcc"

# use gcc for now as it fail with clang with some compile errors:
# error: passing 'unsigned int *' to parameter of type 'int *' converts between pointers to integer types with different sign [-Werror,-Wpointer-sign]
# error: fields must have a constant size: 'variable length array in structure' extension will never be supported
# error: passing 'typeof (((fundle_t)0)) *' (aka 'unsigned int *') to parameter of type '__s32 *' (aka 'int *') converts between pointers to integer types with different sign [-Werror,-Wpointer-sign]
TOOLCHAIN:pn-xenomai4 = "gcc"

# qemuarm64-secureboot
# | ld.lld: error: cannot open /usr/lib/clang/14.0.3/lib/linux/libclang_rt.builtins-aarch64.a: No such file or directory
#  /srv/oe/build/conf/../../layers/meta-lmp/meta-lmp-base/recipes-security/optee/optee-os-fio_3.17.0.bb:do_compile
#  /srv/oe/build/conf/../../layers/meta-lmp/meta-lmp-base/recipes-security/optee/optee-os-tadevkit_3.17.0.bb:do_compile
#  /srv/oe/build/conf/../../layers/meta-lmp/meta-lmp-base/recipes-security/optee/optee-test_3.17.0.bb:do_compile
TOOLCHAIN:pn-optee-os-fio = "gcc"
TOOLCHAIN:pn-optee-os-tadevkit = "gcc"
TOOLCHAIN:pn-optee-test = "gcc"
TOOLCHAIN:pn-optee-client = "gcc"
TOOLCHAIN:pn-optee-sks = "gcc"

# qemuarm64
## clang only works with debug mode (not release)
TOOLCHAIN:pn-edk2-firmware = "gcc"

# apalis-imx6-sec
# imx8mm-lpddr4-evk-sec
# imx8mp-lpddr4-evk-sec
# uz3eg-iocc-ebbr-sec
#  /srv/oe/build/conf/../../layers/meta-lmp/meta-lmp-base/recipes-security/optee/optee-fiovb_git.bb:do_compile
TOOLCHAIN:pn-optee-fiovb = "gcc"

# tegra (xavier and orin)
TOOLCHAIN:pn-optee-os = "gcc"
TOOLCHAIN:pn-optee-nvsamples = "gcc"

# lmp-mfgtool distro
TOOLCHAIN:pn-optee-os-fio-mfgtool = "gcc"

# imx targets (not reproducible)
TOOLCHAIN:pn-imx-atf = "gcc"

# kv260
# vck190-versal
# uz3eg-iocc-ebbr-sec
TOOLCHAIN:pn-arm-trusted-firmware = "gcc"

# am64xx-evm
TOOLCHAIN:pn-ti-sci-fw = "gcc"
TOOLCHAIN:pn-trusted-firmware-a = "gcc"

# jetson-agx-xavier-devkit
TOOLCHAIN:pn-nvdisp-init = "gcc"
# edk2-tegra/edk2/MdeModulePkg/Include/Guid/ExtendedFirmwarePerformance.h:137:50: error: field Guid1 within 'FPDT_DUAL_GUID_STRING_EVENT_RECORD' is less aligned than 'EFI_GUID' (aka 'GUID') and is usually due to 'FPDT_DUAL_GUID_STRING_EVENT_RECORD' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
TOOLCHAIN:pn-edk2-firmware-tegra = "gcc"

# stm32mp1
TOOLCHAIN:pn-tf-a-stm32mp = "gcc"
TOOLCHAIN:pn-tf-a-fio = "gcc"

# qemuriscv64
TOOLCHAIN:pn-opensbi = "gcc"

# https://reviews.llvm.org/D34796
# | clang-14: error: unknown argument: '-fno-toplevel-reorder'
# | clang-14: warning: optimization flag '-fno-merge-constants' is not supported [-Wignored-optimization-argument]
TOOLCHAIN:pn-efitools = "gcc"

# github.com/seccomp/libseccomp-golang
# vendor/github.com/seccomp/libseccomp-golang/seccomp_internal.go:619:2: duplicate case _Ciconst_C_ACT_KILL_THREAD (value 0) in switch
#        previous case at vendor/github.com/seccomp/libseccomp-golang/seccomp_internal.go:615:2
TOOLCHAIN:pn-runc-opencontainers = "gcc"

# U-boot does compile with clang but clang-15 crashes compiling it :(
TOOLCHAIN:pn-u-boot-fio = "gcc"
TOOLCHAIN:pn-u-boot-fio-mfgtool = "gcc"
TOOLCHAIN:pn-u-boot-xlnx = "gcc"
TOOLCHAIN:pn-u-boot-ti-staging = "gcc"

# libmali-xlnx calls gcc directly on do_install
TOOLCHAIN:pn-libmali-xlnx = "gcc"
