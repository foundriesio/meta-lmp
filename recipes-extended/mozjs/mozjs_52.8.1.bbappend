FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

CFLAGS += "-fno-schedule-insns2"
CXXFLAGS += "-fno-schedule-insns2"

SRC_URI_append = " \
    file://disable-mozglue-in-stand-alone-builds.patch \
    file://riscv-support.patch \
"
