FILESEXTRAPATHS:prepend := ":${COREBASE}/meta/recipes-core/base-files/base-files:"

def get_pv(d):
    import re
    corebase = d.getVar('COREBASE')
    bb_dir = os.path.join(corebase, 'meta', 'recipes-core', 'base-files')
    if os.path.isdir(bb_dir):
        re_bb_name = re.compile(r"base-files_([0-9.]*)\.bb")
        for bb_file in os.listdir(bb_dir):
            result = re_bb_name.match(bb_file)
            if result:
                return result.group(1)
    bb.fatal("Cannot find base-files recipe in %s" % bb_dir)

PV := "${@get_pv(d)}"

require recipes-core/base-files/base-files_${PV}.bb

SUMMARY += " (only contains /etc/issue*)"
DESCRIPTION += " This package only install the /etc/issue* that have the LmP release (including the build number) to avoid initrd images rebuilding"

SRC_URI = "file://issue.net \
           file://issue \
           file://licenses/GPL-2 \
"

pkg_preinst:${PN} () {
    :
}

do_install () {
    install -d ${D}${sysconfdir}
    do_install_basefilesissue
    # we only need the do_install_basefilesissue and noting more
    # so drop any do_install:append of the main recipe
    return 0
}

SYSROOT_DIRS:remove = "${sysconfdir}/skel"

PACKAGES = "${PN}"

FILES:${PN} = "/etc/issue /etc/issue.net"

CONFFILES:${PN} = ""

INSANE_SKIP:${PN}:remove = "empty-dirs"
