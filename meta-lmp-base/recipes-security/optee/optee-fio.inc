OPTEEMACHINE ?= "${MACHINE}"
OPTEEMACHINE:aarch64:qemuall ?= "vexpress-qemu_armv8a"

OPTEE_ARCH = "null"
OPTEE_ARCH:armv7a = "arm32"
OPTEE_ARCH:armv7ve = "arm32"
OPTEE_ARCH:aarch64 = "arm64"
OPTEE_CORE = "${@d.getVar('OPTEE_ARCH').upper()}"

OPTEE_TOOLCHAIN = "${@d.getVar('TOOLCHAIN') or 'gcc'}"
OPTEE_COMPILER = "${@bb.utils.contains("BBFILE_COLLECTIONS", "clang-layer", "${OPTEE_TOOLCHAIN}", "gcc", d)}"

# Set here but not passed to EXTRA_OEMAKE by default as that breaks
# the optee-os build
TA_DEV_KIT_DIR = "${STAGING_INCDIR}/optee/export-user_ta"

inherit python3native

DEPENDS += "python3-cryptography-native"

# TA Signing Key, can be set to replace the default RSA 2048 key (default_key.pem)
OPTEE_TA_SIGN_KEY ?= ""
EXTRA_OEMAKE += "${@oe.utils.ifelse('${OPTEE_TA_SIGN_KEY}' != '', 'TA_SIGN_KEY=${OPTEE_TA_SIGN_KEY}', '')}"

EXTRA_OEMAKE += "V=1 \
                 LIBGCC_LOCATE_CFLAGS=--sysroot=${STAGING_DIR_HOST} \
                 COMPILER=${OPTEE_COMPILER} \
                 OPTEE_CLIENT_EXPORT=${STAGING_DIR_HOST}${prefix} \
                 TEEC_EXPORT=${STAGING_DIR_HOST}${prefix} \
                 PYTHON3=${PYTHON} \
                "
# python3-cryptography needs the legacy provider, so set OPENSSL_MODULES to the
# right path until this is relocated automatically.
export OPENSSL_MODULES="${STAGING_LIBDIR_NATIVE}/ossl-modules"
