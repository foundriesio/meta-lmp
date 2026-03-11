FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:lmp = " \
	file://cli-config-support-default-system-config.go-mod-patch \
"

do_patch_gomodcache() {
	MODPATH="${S}/pkg/mod/github.com/docker/cli@v29.2.1+incompatible"
	patch -p1 -d ${MODPATH} < ${UNPACKDIR}/cli-config-support-default-system-config.go-mod-patch
}
addtask patch_gomodcache after do_create_module_cache before do_compile
