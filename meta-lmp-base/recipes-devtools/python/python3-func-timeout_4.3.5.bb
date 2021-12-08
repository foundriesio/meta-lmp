SUMMARY = "Support running any existing function with a given timeout"
HOMEPAGE = "https://github.com/kata198/func_timeout"
SECTION = "devel/python"
LICENSE = "LGPLv3 & LGPL-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e6a600fd5e1d9cbde2d983680233ad02"

inherit pypi setuptools3

PYPI_PACKAGE = "func_timeout"

SRC_URI[sha256sum] = "74cd3c428ec94f4edfba81f9b2f14904846d5ffccc27c92433b8b5939b5575dd"

BBCLASSEXTEND = "native nativesdk"
