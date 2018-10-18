FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV_lloader = "d71c0f6455519c349f684a734f034b5d2ec91177"

SRC_URI_append = " \
    file://0001-generate_ptable.sh-drop-fakeroot-not-needed.patch \
"
