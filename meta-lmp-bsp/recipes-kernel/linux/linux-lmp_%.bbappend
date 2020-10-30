FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_icicle-kit-es = " \
    file://0001-PFSoC-Icicle-kit-Adding-DTS-makefile.patch \
    file://0002-Microchip-Polarfire-SoC-Clock-Driver.patch \
    file://0003-PFSoC-MAC-Interface-auto-negotiation.patch \
    file://0004-Microchip-Support-for-the-Polarfire-SoC.patch \
    file://0005-Microchip-Adding-I2C-Support-for-the-Polarfire-SoC.patch \
    file://0006-add-Microchip-pac1934x-ADC-driver.patch \
    file://icicle-kit-es-standard.scc \
    file://icicle-kit-es.scc \
    file://icicle-kit-es.cfg \
"

KERNEL_FEATURES_remove_icicle-kit-es = "features/debug/printk.scc"
KERNEL_FEATURES_remove_icicle-kit-es = "features/kernel-sample/kernel-sample.scc"
