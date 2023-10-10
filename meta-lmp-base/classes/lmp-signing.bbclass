# Foundries LmP signing
#
# This class will implement some pending fuctionality we have
# and some workarounds needed in LmP for signing.
#
# Copyright 2023 (C) Foundries.IO LTD

SIGNING_MODSIGN_PRIVKEY ?= "${MODSIGN_PRIVKEY}"
SIGNING_MODSIGN_X509 ?= "${MODSIGN_X509}"

# uefi keys
SIGNING_UEFI_SIGN_KEY ?= "${UEFI_SIGN_KEYDIR}/DB.key"
SIGNING_UEFI_SIGN_CRT ?= "${UEFI_SIGN_KEYDIR}/DB.crt"

# u-boot keys
SIGNING_UBOOT_SIGN_KEY ?= "${UBOOT_SIGN_KEYDIR}/${UBOOT_SIGN_KEYNAME}.key"
SIGNING_UBOOT_SIGN_CRT ?= "${UBOOT_SIGN_KEYDIR}/${UBOOT_SIGN_KEYNAME}.crt"

# u-boot spl keys
SIGNING_UBOOT_SPL_SIGN_KEY ?= "${UBOOT_SIGN_KEYDIR}/${UBOOT_SPL_SIGN_KEYNAME}.key"
SIGNING_UBOOT_SPL_SIGN_CRT ?= "${UBOOT_SIGN_KEYDIR}/${UBOOT_SPL_SIGN_KEYNAME}.crt"

python __anonymous() {
    pn = d.getVar('PN')

    # kernel modules keys
    if bb.data.inherits_class('kernel-modsign', d):
        add_varfiles_hash_to_vardeps_of_var(('SIGNING_MODSIGN_PRIVKEY', 'SIGNING_MODSIGN_X509'), 'kernel_do_configure', d)

    # uefi keys
    if pn == 'systemd-boot' or bb.data.inherits_class('kernel-lmp-efi', d):
        add_varfiles_hash_to_vardeps_of_var(('SIGNING_UEFI_SIGN_KEY', 'SIGNING_UEFI_SIGN_CRT'), 'do_efi_sign', d)
    if pn == 'efitools':
        add_varfiles_hash_to_vardeps_of_var(('SIGNING_UEFI_SIGN_KEY', 'SIGNING_UEFI_SIGN_CRT'), 'do_prepare_local_auths', d)

    # u-boot keys
    if bb.data.inherits_class('kernel-lmp-fitimage', d):
        add_varfiles_hash_to_vardeps_of_var(('SIGNING_UBOOT_SIGN_KEY', 'SIGNING_UBOOT_SIGN_CRT'), 'do_assemble_fitimage_initramfs', d)
    if pn == 'u-boot-ostree-scr-fit':
        add_varfiles_hash_to_vardeps_of_var(('SIGNING_UBOOT_SIGN_KEY', 'SIGNING_UBOOT_SIGN_CRT'), 'do_compile', d)

    # u-boot spl keys
    if bb.data.inherits_class('uboot-fitimage', d):
        add_varfiles_hash_to_vardeps_of_var(('SIGNING_UBOOT_SPL_SIGN_KEY', 'SIGNING_UBOOT_SPL_SIGN_CRT'), 'do_deploy', d)
}

def set_varfile_hash(varfile, d):
    import os
    import hashlib

    varname_hash = '%s_HASH' % varfile
    if not d.getVar(varname_hash):
        filename = d.getVar(varfile)
        if filename is None:
            bb.fatal('%s is not set.' % varfile)
        if not os.path.isfile(filename):
            bb.fatal('%s=%s is not a file.' % (varfile, filename))
        with open(filename, 'rb') as f:
            data = f.read()

        hash = hashlib.sha256(data).hexdigest()
        d.setVar(varname_hash, hash)
        bb.debug(1, "Adds %s: %s %s" % (varname_hash, hash, filename))
        # We need to re-parse each time the file changes, and bitbake
        # needs to be told about that explicitly.
        bb.parse.mark_dependency(d, filename)

    return varname_hash

def add_varfiles_hash_to_vardeps_of_var(varfiles, var, d):
    for varname in varfiles:
        varname_hash = set_varfile_hash(varname, d)
        vardeps = d.getVarFlag(var, 'vardeps')
        if vardeps and varname_hash not in vardeps:
            d.appendVarFlag(var, 'vardeps', ' ' + varname_hash)
