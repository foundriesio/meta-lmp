SUMMARY = "Make entry_points specified in setup.py load more quickly"
DESCRIPTION = "Using entry_points in your setup.py makes scripts that start \
really slowly because it imports pkg_resources, which is a horrible \
thing to do if you want your trivial script to execute more or less \
instantly. fastentrypoints aims to fix that bypassing pkg_resources, \
making scripts load a lot faster."
HOMEPAGE = "https://github.com/ninjaaron/fast-entry_points"
SECTION = "devel/python"

LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://README.rst;md5=f212a0cb34eb678477972d2011fb365a"

inherit pypi setuptools3

SRC_URI[md5sum] = "390ad9a9229164a06156a5b1f0ef1b22"
SRC_URI[sha256sum] = "ff284f1469bd65400599807d2c6284d5b251398e6e28811f5f77fd262292410b"

BBCLASSEXTEND = "native nativesdk"
