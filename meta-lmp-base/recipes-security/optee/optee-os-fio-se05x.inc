# Different license due Plug-And-Trust
LICENSE:append = " & BSD-3-Clause & Apache-2.0"
LIC_FILES_CHKSUM:append = " \
    file://${COMMON_LICENSE_DIR}/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9 \
    file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10 \
"

SRC_URI:append = " \
    git://github.com/foundriesio/plug-and-trust.git;protocol=https;branch=optee_lib-v4;name=plug-and-trust;destsuffix=git/plug-and-trust \
    file://se050_applet_version.patch \
"
SRCREV_plug-and-trust ?= "c46f7c9b4b42268314c58bae2c42aed0e4c0f640"

# To be replaced based on the actual board OEFID
SE05X_OEFID ?= "0xA1F4"

# Some SE05X versions do not support the RSA cipher
SE05X_HW_RSA ?= "y"

# Some SE05X versions do not support unauthenticated sessions
SE05X_SCP03_ONLY ?= "n"

python () {
    oefid = d.getVar("SE05X_OEFID")
    if oefid in ["0xA565", "0xA564"]:
        d.setVar('SE05X_VER', "06_00")
    elif oefid == "0xA921":
        d.setVar('SE05X_VER', "07_02")
        d.setVar('SE05X_HW_RSA', "n")
    elif oefid in ["0xA92A", "0xA77E"]:
        d.setVar('SE05X_VER', "03_XX")
        d.setVar('SE05X_SCP03_ONLY', "y")
    else:
        d.setVar('SE05X_VER', "03_XX")
}

# Used by OP-TEE OS
EXTRA_OEMAKE:append = " \
    CFG_STACK_THREAD_EXTRA=8192 \
    CFG_STACK_TMP_EXTRA=8192 \
    CFG_NXP_SE05X=y \
    CFG_CORE_SCP03_ONLY=${SE05X_SCP03_ONLY} \
    CFG_CORE_SE05X_VER=${SE05X_VER} \
    CFG_CORE_SE05X_DISPLAY_INFO=1 \
    CFG_CORE_SE05X_SCP03_EARLY=y \
    CFG_CORE_SE05X_OEFID=${SE05X_OEFID} \
    CFG_CRYPTO_DRV_CIPHER=y \
    CFG_CRYPTO_DRV_ACIPHER=y \
    CFG_NXP_SE05X_SCP03_DRV=y \
    CFG_NXP_SE05X_APDU_DRV=y \
    CFG_NXP_SE05X_RSA_DRV=${SE05X_HW_RSA} \
    CFG_NXP_SE05X_ECC_DRV=y \
    CFG_NXP_SE05X_CTR_DRV=y \
    CFG_NXP_SE05X_DIEID_DRV=y \
    CFG_NXP_SE05X_RNG_DRV=n \
    CFG_NXP_SE05X_PLUG_AND_TRUST=${S}/plug-and-trust \
"
# Fix conflicts with CAAM crypto hw drivers
EXTRA_OEMAKE:remove = " \
    CFG_CRYPTO_DRIVER=y \
"
