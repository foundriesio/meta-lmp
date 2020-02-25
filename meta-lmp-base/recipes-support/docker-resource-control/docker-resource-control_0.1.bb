SUMMARY = "Docker resource control file"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit allarch

RDEPENDS_${PN} = "docker"

SRC_URI = "file://10-resource-control.conf.in"
S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

# caps CPU usage by docker.service -- this is total across all cores

# can be overriden in configuration with `RESOURCE_xxx_pn-docker-resource-control`
# see `man systemd.resource-control` for details

# Examples:
# capped at 20% on 1 core or 10% on 2 cores, or 5% on 4 cores
# RESOURCE_CPU_QUOTA = "20%"
# not limited (default)
RESOURCE_CPU_QUOTA = "-1"

do_compile() {
    sed -e 's/@@CPU_QUOTA@@/${RESOURCE_CPU_QUOTA}/' \
        ${S}/10-resource-control.conf.in > ${S}/10-resource-control.conf
}

do_install() {
    # resource control
    install -d ${D}/${systemd_system_unitdir}/docker.service.d
    install -m 0644 ${S}/10-resource-control.conf ${D}/${systemd_system_unitdir}/docker.service.d
}

FILES_${PN} = " \
    ${systemd_system_unitdir}/docker.service.d/10-resource-control.conf \
"
