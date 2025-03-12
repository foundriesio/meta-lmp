FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:imx8mm-lpddr4-evk = " file://disable_control_port_over_nl80211.patch"
