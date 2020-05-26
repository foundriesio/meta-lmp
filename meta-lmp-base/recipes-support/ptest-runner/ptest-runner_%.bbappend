FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_lmp = " \
	file://ptest-lmp-runner.sh \
"

do_install_append_lmp() {
	install -D -m 0755 ${WORKDIR}/ptest-lmp-runner.sh ${D}${bindir}/ptest-lmp-runner
}

FILES_${PN}_append_lmp = " ${bindir}/ptest-lmp-runner"
