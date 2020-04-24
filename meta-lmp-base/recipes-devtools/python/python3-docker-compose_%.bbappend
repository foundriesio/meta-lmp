FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

# Add in support for compose bundles
SRC_URI += "file://0001-Add-concept-of-compose-apps.patch"
