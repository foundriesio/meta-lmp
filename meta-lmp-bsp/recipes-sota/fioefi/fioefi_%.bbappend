FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://fioefi-soc.sh.in"

RDEPENDS:${PN}:append:tegra = " setup-nv-boot-control tegra-uefi-capsules"

do_compile:prepend() {
    sed -e '/@@INCLUDE_SOC_FUNCTIONS@@/ {' -e 'r ${S}/fioefi-soc.sh.in' -e 'd' -e '}' \
        ${S}/fioefi.sh.in > ${B}/fioefi
}
