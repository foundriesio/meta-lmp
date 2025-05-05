FILESEXTRAPATHS:prepend := "${@bb.utils.contains('SOC_FAMILY', 'tegra194', '${THISDIR}/tegra-helper-scripts:', '', d)}"
