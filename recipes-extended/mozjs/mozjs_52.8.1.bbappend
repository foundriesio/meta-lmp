FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

CFLAGS += "-fno-schedule-insns2"
CXXFLAGS += "-fno-schedule-insns2"

SRC_URI_append = " \
    file://riscv-support.patch \
"
