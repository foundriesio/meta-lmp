FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Disable null pointer optimization in gcc >= 6
# https://bugzilla.redhat.com/show_bug.cgi?id=1328045
CFLAGS += "-fno-tree-vrp -fno-strict-aliasing -fno-delete-null-pointer-checks"
CXXFLAGS += "-fno-tree-vrp -fno-strict-aliasing -fno-delete-null-pointer-checks"

SRC_URI_append = " \
    file://riscv-support.patch \
"
