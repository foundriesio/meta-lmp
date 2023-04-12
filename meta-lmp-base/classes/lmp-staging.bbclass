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

    if bb.data.inherits_class('module', d):
        d.appendVar('DEPENDS', ' virtual/kernel')
        if 'modsign' in d.getVar('DISTRO_FEATURES'):
            d.setVar('LMPSTAGING_INHERIT_KERNEL_MODSIGN', 'kernel-modsign')

    if bb.data.inherits_class('go-mod', d):
        d.setVarFlag('do_compile', 'network', '1')

    if pn in d.getVar('LMPSTAGING_LOCK_TO_AVOID_OOM').split():
        d.appendVarFlag('do_compile', 'lockfiles', " ${TMPDIR}/lmp-hack-avoid-oom-do_compile.lock")

    if bb.data.inherits_class('image_types_wic', d) and \
        'k3' in d.getVar('MACHINEOVERRIDES').split(':') and \
        all(bbmc.startswith('lmp-k3r5') for bbmc in d.getVar('BBMULTICONFIG').split()):
            mcdepends = d.getVarFlag('do_image_wic', 'mcdepends')
            d.setVarFlag('do_image_wic', 'mcdepends', mcdepends.replace(':k3r5', ':lmp-k3r5'))
}

inherit ${LMPSTAGING_INHERIT_KERNEL_MODSIGN}

BB_HASHCHECK_FUNCTION:lmp = "lmp_sstate_checkhashes"
def lmp_sstate_checkhashes(sq_data, d, **kwargs):
    mirrors = d.getVar("SSTATE_MIRRORS")
    if mirrors:
        bb.plain("SState mirrors: %s" % mirrors)
    return sstate_checkhashes(sq_data, d, **kwargs)
