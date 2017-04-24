FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://0001-mx6-solidrun-add-support-for-hummingboard2.patch \
    file://fix-partition_uuids.patch \
"
