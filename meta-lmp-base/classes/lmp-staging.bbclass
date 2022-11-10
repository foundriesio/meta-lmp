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
        d.setVarFlag('do_compile', 'network', '1')

    if pn in ["clang", "rust"]:
        d.appendVarFlag('do_compile', 'lockfiles', " ${TMPDIR}/lmp-hack-avoid-oom-do_compile.lock")

    if bb.data.inherits_class('archiver', d) and is_work_shared(d) and \
        d.getVarFlag('ARCHIVER_MODE', 'src') == "original" and \
        d.getVarFlag('ARCHIVER_MODE', 'diff') == '1':
            d.setVarFlag('do_deploy_archives', 'vardepvalue', '%s:do_unpack_and_patch' % pn)
}

inherit ${INHERIT_KERNEL_MODSIGN}
