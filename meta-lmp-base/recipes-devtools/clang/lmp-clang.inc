FILESEXTRAPATHS:prepend := "${THISDIR}/clang:"

SRC_URI:append:x86 = " file://0036-builtins-Build-float128-soft-float-builtins-for-x86_.patch"
SRC_URI:append:x86-64 = " file://0036-builtins-Build-float128-soft-float-builtins-for-x86_.patch"
