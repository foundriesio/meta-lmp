FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:lmp = " \
	file://ptest-lmp-runner.sh \
"

do_install:append:lmp() {
	install -D -m 0755 ${WORKDIR}/ptest-lmp-runner.sh ${D}${bindir}/ptest-lmp-runner
}

FILES:${PN}:append:lmp = " ${bindir}/ptest-lmp-runner"
