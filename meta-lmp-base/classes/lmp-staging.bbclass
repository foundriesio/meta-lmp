# Foundries LmP staging area
#
# This class will implement some pending patches that we have
# and some workarounds needed in LmP.
#
# Copyright 2022-2023 (C) Foundries.IO LTD

LMPSTAGING_INHERIT_KERNEL_MODSIGN = ""

LMPSTAGING_LOCK_TO_AVOID_OOM = "clang-native rust-native rust-llvm-native"

python __anonymous() {
    pn = d.getVar('PN')

    if d.getVar('RM_WORK_EXCLUDE_ALL') != "":
        d.delVarFlag('rm_work_rootfs', 'cleandirs')
        d.delVarFlag('rm_work_populatesdk', 'cleandirs')

    if bb.data.inherits_class('module', d):
        d.appendVar('DEPENDS', ' virtual/kernel')
        if 'modsign' in d.getVar('DISTRO_FEATURES'):
            d.setVar('LMPSTAGING_INHERIT_KERNEL_MODSIGN', 'kernel-modsign')

    if bb.data.inherits_class('go-mod', d):
        d.setVarFlag('do_compile', 'network', '1')

    if pn in d.getVar('LMPSTAGING_LOCK_TO_AVOID_OOM').split():
        d.appendVarFlag('do_compile', 'lockfiles', " ${TMPDIR}/lmp-hack-avoid-oom-do_compile.lock")
}

inherit_defer ${LMPSTAGING_INHERIT_KERNEL_MODSIGN}

RM_WORK_EXCLUDE_ALL ?= ""
do_rm_work:prepend () {
    if [ "${RM_WORK_EXCLUDE_ALL}" != "" ]; then
        bbnote "rm_work: Skipping as RM_WORK_EXCLUDE_ALL is defined"
        exit 0
     fi
}

BB_HASHCHECK_FUNCTION:lmp = "lmp_sstate_checkhashes"
def lmp_sstate_checkhashes(sq_data, d, **kwargs):
    if 'summary' not in kwargs or kwargs.get('summary'):
        mirrors = d.getVar("SSTATE_MIRRORS")
        if mirrors:
            mirrors = " ".join(mirrors.split())
            bb.plain("SState mirrors: %s" % mirrors)
    return sstate_checkhashes(sq_data, d, **kwargs)
