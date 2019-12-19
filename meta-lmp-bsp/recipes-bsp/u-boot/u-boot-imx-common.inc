# Copyright (C) 2013-2016 Freescale Semiconductor
# Copyright 2018 (C) O.S. Systems Software LTDA.
# Copyright 2017-2019 NXP

HOMEPAGE = "http://www.denx.de/wiki/U-Boot/WebHome"
DESCRIPTION = "i.MX U-Boot suppporting i.MX reference boards."
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"
DEPENDS += "flex-native bison-native"

SRCBRANCH = "imx_v2019.04_4.19.35_1.1.0"
SRC_URI = "git://source.codeaurora.org/external/imx/uboot-imx.git;protocol=https;branch=${SRCBRANCH}"
SRCREV = "4d377539a1190e838eae5d8b8a794dde0696d572"

S = "${WORKDIR}/git"
