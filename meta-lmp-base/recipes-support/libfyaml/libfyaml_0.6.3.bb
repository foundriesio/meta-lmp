SUMMARY = "A fancy 1.3 YAML and JSON parser/writer."
HOMEPAGE = "https://github.com/pantoniou/libfyaml"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=6399094fbc639a289cfca2d660c010aa"

SRC_URI = "https://github.com/pantoniou/libfyaml/releases/download/v${PV}/libfyaml-${PV}.tar.gz"
SRC_URI[sha256sum] = "aba6e5b1667bb5a05318f0ad70c617345f2a9e5ce79b37ff1e5322162c9a033e"

S = "${WORKDIR}/libfyaml-${PV}"

inherit autotools pkgconfig
