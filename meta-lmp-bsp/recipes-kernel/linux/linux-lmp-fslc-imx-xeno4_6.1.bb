FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:${THISDIR}/linux-lmp-fslc-imx/${KSHORT_VER}:${THISDIR}/linux-lmp-fslc-imx:"

include linux-lmp-fslc-imx_6.1.bb

# Merge branch 'expand-stack': fixes use-after-frer-by-RCU vulnerability
SRC_URI += " \
    file://0001-mm-introduce-new-lock_mm_and_find_vma-page-fault-hel.patch \
    file://0002-mm-make-the-page-fault-mmap-locking-killable.patch \
    file://0003-arm64-mm-Convert-to-using-lock_mm_and_find_vma.patch \
    file://0004-mm-fault-convert-remaining-simple-cases-to-lock_mm_a.patch \
    file://0005-powerpc-mm-convert-coprocessor-fault-to-lock_mm_and_.patch \
    file://0006-mm-make-find_extend_vma-fail-if-write-lock-not-held.patch \
    file://0007-execve-expand-new-process-stack-manually-ahead-of-ti.patch \
    file://0008-mm-always-expand-the-stack-with-the-mmap-write-lock-.patch \
    file://0009-sparc32-fix-lock_mm_and_find_vma-conversion.patch \
    file://0010-parisc-fix-expand_stack-conversion.patch \
    file://0011-csky-fix-up-lock_mm_and_find_vma-conversion.patch \
    file://0012-xtensa-fix-NOMMU-build-with-lock_mm_and_find_vma-con.patch \
"

KERNEL_REPO = "git://github.com/foundriesio/linux.git"
LINUX_VERSION = "6.1.24"
KERNEL_BRANCH = "6.1-1.0.x-imx-xeno4"

SRCREV_machine = "25aa4b67c7364c4e628b0ce2e12429b287937b76"
LINUX_KERNEL_TYPE = "xeno4"
