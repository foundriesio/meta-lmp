# Foundries LmP staging area
#
# This class will implement some pending patches that we have
# and some workarounds needed in LmP.
#
# Copyright 2022-2023 (C) Foundries.IO LTD

LMPSTAGING_INHERIT_KERNEL_MODSIGN = ""

LMPSTAGING_LOCK_TO_AVOID_OOM = "clang-native rust-native rust-llvm-native"

LMPSTAGING_KERN_ADD_ST_SUBDIR = ""

python __anonymous() {
    pn = d.getVar('PN')

    if pn == "linux-lmp" or pn == "linux-lmp-rt":
        (major_ver, minor_ver, rest) = d.getVar('LINUX_VERSION').split(".")
        if int(major_ver) > 6 or (int(major_ver) == 6 and int(minor_ver) >= 4):
            d.setVar('LMPSTAGING_KERN_ADD_ST_SUBDIR',  'st/')

    if bb.data.inherits_class('module', d):
        d.appendVar('DEPENDS', ' virtual/kernel')
        if 'modsign' in d.getVar('DISTRO_FEATURES'):
            d.setVar('LMPSTAGING_INHERIT_KERNEL_MODSIGN', 'kernel-modsign')

    if bb.data.inherits_class('go-mod', d):
        d.setVarFlag('do_compile', 'network', '1')

    if pn in d.getVar('LMPSTAGING_LOCK_TO_AVOID_OOM').split():
        d.appendVarFlag('do_compile', 'lockfiles', " ${TMPDIR}/lmp-hack-avoid-oom-do_compile.lock")
}

inherit ${LMPSTAGING_INHERIT_KERNEL_MODSIGN}

BB_HASHCHECK_FUNCTION:lmp = "lmp_sstate_checkhashes"
def lmp_sstate_checkhashes(sq_data, d, **kwargs):
    if 'summary' not in kwargs or kwargs.get('summary'):
        mirrors = d.getVar("SSTATE_MIRRORS")
        if mirrors:
            mirrors = " ".join(mirrors.split())
            bb.plain("SState mirrors: %s" % mirrors)
    return sstate_checkhashes(sq_data, d, **kwargs)
