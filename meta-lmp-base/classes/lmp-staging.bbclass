# Foundries LmP staging area
#
# This class will implement some pending patches that we have
# and some workarounds needed in LmP.
#
# Copyright 2022 (C) Foundries.IO LTD

INHERIT_KERNEL_MODSIGN = ""

python __anonymous() {
    pn = d.getVar('PN')

    if bb.data.inherits_class('module', d):
        d.appendVar('DEPENDS', ' virtual/kernel')
        if 'modsign' in d.getVar('DISTRO_FEATURES'):
            d.setVar('INHERIT_KERNEL_MODSIGN', 'kernel-modsign')

    if bb.data.inherits_class('go-mod', d):
        d.appendVarFlag('do_compile', 'network', '1')

    if pn in ["clang", "rust"]:
        d.appendVarFlag('do_compile', 'lockfiles', " ${TMPDIR}/lmp-hack-avoid-oom-do_compile.lock")
}

inherit ${INHERIT_KERNEL_MODSIGN}
