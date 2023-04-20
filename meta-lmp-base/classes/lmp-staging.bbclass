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
            task = "do_image_complete"
            mcdepends = d.getVarFlag(task, 'mcdepends')
            d.setVarFlag(task, 'mcdepends', mcdepends.replace(':k3r5', ':lmp-k3r5'))
}

inherit ${LMPSTAGING_INHERIT_KERNEL_MODSIGN}

BB_HASHCHECK_FUNCTION:lmp = "lmp_sstate_checkhashes"
def lmp_sstate_checkhashes(sq_data, d, **kwargs):
    mirrors = d.getVar("SSTATE_MIRRORS")
    if mirrors:
        bb.plain("SState mirrors: %s" % mirrors)
    return sstate_checkhashes(sq_data, d, **kwargs)

# don't check images
LMPSTAGING_DEPLOYED_CHECK_SKIP ?= "${@d.getVar('PN') if bb.data.inherits_class('image', d) else ''}"

# handler to warn when there are 'do_deploy' dependencies without setting the DEPENDS
addhandler check_deployed_depends
check_deployed_depends[eventmask] = "bb.build.TaskSucceeded"
python check_deployed_depends() {
    d = e.data

    taskname = d.getVar('BB_RUNTASK')
    pn = d.getVar('PN')
    pn = [pn, '%s:%s' % (pn, taskname)]
    excludes = (d.getVar('LMPSTAGING_DEPLOYED_CHECK_SKIP') or '').split()
    for s in excludes:
        if s in pn:
            bb.debug(1, "skip '%s' deployed dependencies check" % s)
            return

    depends = (d.getVarFlag(taskname, 'depends') or '').split()
    # remove duplicates
    depends = [*set(depends)]
    for depend in depends:
        recipe, task = depend.split(':')
        if task == 'do_deploy' and recipe not in d.getVar('DEPENDS'):
            bb.error("Task '%s' depends on '%s' but '%s' is not in DEPENDS" % (taskname, depend, recipe))
}

def fix_deployed_depends(task, d):
    # we need to set the DEPENDS as well to produce valid SPDX documents
    for depend in (d.getVarFlag(task, 'depends') or '').split():
        recipe, task = depend.split(':')
        if task == 'do_deploy':
            d.appendVar('DEPENDS', ' %s' % recipe)
