FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://hi6220-hikey.dtb \
"

do_compile_prepend() {
    cp -a ${WORKDIR}/hi6220-hikey.dtb ${S}/OpenPlatformPkg/Platforms/Hisilicon/DeviceTree/hi6220-hikey.dtb
}
