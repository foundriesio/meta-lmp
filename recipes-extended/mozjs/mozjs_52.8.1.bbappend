FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://disable-mozglue-in-stand-alone-builds.patch \
"
