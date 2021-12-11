# Different license due Plug-And-Trust
LICENSE_append = " & BSD-3-Clause & Apache-2.0"
LIC_FILES_CHKSUM_append = " \
    file://${COMMON_LICENSE_DIR}/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9 \
    file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10 \
"

SRC_URI_append = " \
    git://github.com/foundriesio/plug-and-trust.git;protocol=https;branch=optee_lib;name=plug-and-trust;destsuffix=git/plug-and-trust \
"
SRCREV_plug-and-trust ?= "63ef731fa40ceab71d377c6db774bb98fa243105"

# Not an issue as OP-TEE OS is not yet being built with cmake
inherit cmake

OECMAKE_SOURCEPATH = "${S}/plug-and-trust/optee_lib"

# To be replaced based on the actual board OEFID
SE05X_OEFID ?= "0xA1F4"

python () {
    oefid = d.getVar("SE05X_OEFID")
    if oefid in ["0xA565", "0xA564"]:
        d.setVar('SE05X_VER', "06_00")
    else:
        d.setVar('SE05X_VER', "03_XX")
}

EXTRA_OECMAKE = "-DOPTEE_TREE=${S} -DSE05X_Ver=${SE05X_VER}"

# Used by OP-TEE OS
EXTRA_OEMAKE_append = " \
    CFG_NUM_THREADS=1 \
    CFG_STACK_THREAD_EXTRA=8192 \
    CFG_STACK_TMP_EXTRA=8192 \
    CFG_NXP_SE05X=y \
    CFG_CORE_SE05X_VER=${SE05X_VER} \
    CFG_CORE_SE05X_DISPLAY_INFO=1 \
    CFG_CORE_SE05X_SCP03_EARLY=y \
    CFG_CORE_SE05X_OEFID=${SE05X_OEFID} \
    CFG_CRYPTO_DRV_CIPHER=y \
    CFG_CRYPTO_DRV_ACIPHER=y \
    CFG_PKCS11_TA_TOKEN_COUNT=1 \
    CFG_NXP_SE05X_SCP03_DRV=y \
    CFG_NXP_SE05X_APDU_DRV=y \
    CFG_NXP_SE05X_RSA_DRV=y \
    CFG_NXP_SE05X_ECC_DRV=y \
    CFG_NXP_SE05X_CTR_DRV=y \
    CFG_NXP_SE05X_DIEID_DRV=y \
    CFG_NXP_SE05X_RNG_DRV=n \
    CFG_NXP_SE05X_PLUG_AND_TRUST=${S}/plug-and-trust \
    CFG_NXP_SE05X_PLUG_AND_TRUST_LIB=${B}-plug-and-trust/libse050.a \
"
# Fix conflicts with CAAM crypto hw drivers
EXTRA_OEMAKE_remove = " \
    CFG_CRYPTO_DRIVER=y \
"

# Needed similar cflags as used by OP-TEE internally
OECMAKE_C_FLAGS_append_aarch64 = " -mstrict-align -mgeneral-regs-only"

# We abuse the main configure task from OP-TEE as it is noexec by default
python () {
    d.delVarFlag("do_configure", "noexec")
}
do_configure[cleandirs] = "${B}-plug-and-trust"
do_configure[dirs] = "${B}-plug-and-trust"

do_compile_plug_and_trust_prepend_armv7ve() {
    # OP-TEE core can only consume soft float-based binaries, so update
    # build.binja manually as if changed via CFLAGS cmake will fail
    # when configuring (identifying the compiler abi)
    sed -i "s/-mfpu=neon -mfloat-abi=hard/-mfloat-abi=soft/g" ${B}-plug-and-trust/build.ninja
    mkdir -p ${S}/plug-and-trust/optee_lib/glue/include/gnu
    touch ${S}/plug-and-trust/optee_lib/glue/include/gnu/stubs-soft.h
}
do_compile_plug_and_trust() {
    ${CMAKE_VERBOSE} cmake --build '${B}-plug-and-trust' --target all
}
addtask compile_plug_and_trust after do_configure before do_compile
