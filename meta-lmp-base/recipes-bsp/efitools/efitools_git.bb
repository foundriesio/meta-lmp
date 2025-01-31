require efitools.inc

# The generated native binaries are used during native and target build
DEPENDS += "${BPN}-native gnu-efi openssl"

SRC_URI += " \
    file://LockDown-enable-the-enrollment-for-DBX.patch \
    file://LockDown-show-the-error-message-with-3-sec-timeout.patch \
    file://Makefile-do-not-build-signed-efi-image.patch \
    file://Build-DBX-by-default.patch \
    file://LockDown-disable-the-entrance-into-BIOS-setup-to-re-.patch \
    file://Fix-help2man-error.patch \
    file://0001-Enable-RISC-V-build.patch \
    file://build-keys-for-lockdown-only.patch \
    file://allow-local-auths.patch \
    file://lockdown.conf \
"

# UnLock needs the user keys
SRC_URI:append = "${@bb.utils.contains('UEFI_SIGN_ENABLE', '1', ' file://unlock.patch file://unlock.conf', '', d)}"

COMPATIBLE_HOST = "(i.86|x86_64|arm|aarch64|riscv64).*-linux"

inherit deploy

EXTRA_OEMAKE += " \
    INCDIR_PREFIX='${STAGING_DIR_TARGET}' \
    CRTPATH_PREFIX='${STAGING_DIR_TARGET}' \
    SIGN_EFI_SIG_LIST='${STAGING_BINDIR_NATIVE}/sign-efi-sig-list' \
    CERT_TO_EFI_SIG_LIST='${STAGING_BINDIR_NATIVE}/cert-to-efi-sig-list' \
    CERT_TO_EFI_HASH_LIST='${STAGING_BINDIR_NATIVE}/cert-to-efi-hash-list' \
    HASH_TO_EFI_SIG_LIST='${STAGING_BINDIR_NATIVE}/hash-to-efi-sig-list' \
    HELP2MAN_PROG_PREFIX='${STAGING_BINDIR_NATIVE}' \
    PREBUILT_KEYS='${STAGING_BINDIR_NATIVE}' \
    ${@'USE_LOCAL_AUTHS=1' if d.getVar('UEFI_SIGN_ENABLE') == '1' else ''} \
"

python do_prepare_local_auths() {
    if d.expand('${UEFI_SIGN_ENABLE}') != '1':
        return

    # Prepare PK, KEK, DB and DBX auths for LockDown.efi.
    dir = d.expand('${UEFI_SIGN_KEYDIR}/')

    import shutil
    import os

    # Generate noPK.auth and noKEK.auth if they do not exist
    for _ in ('PK', 'KEK', 'DB', 'DBX', 'noPK', 'noKEK'):
        file = _ + '.auth'
        src = os.path.join(dir, file)
        if not os.path.isfile(src):
            if _ in ('noPK', 'noKEK'):
                bb.note("Generating '%s' in WORKDIR" % file)
                esl_file = os.path.join(d.getVar('WORKDIR'), _ + '.esl')
                auth_file = os.path.join(d.getVar('WORKDIR'), file)
                os.system('touch ' + esl_file)
                os.system('sign-efi-sig-list -t "$(date --date=\'1 second\' +\'%Y-%m-%d %H:%M:%S\')" \
                    -c ' + os.path.join(dir, _.upper()[2:] + '.crt') + ' \
                    -k ' + os.path.join(dir, _.upper()[2:] + '.key') + ' \
                    ' + _.upper() + ' ' + esl_file + ' ' + auth_file)
                src = auth_file
                if not os.path.isfile(src):
                    bb.fatal("File '%s' not found!" % src)
                else:
                    bb.note("Using '%s' from WORKDIR" % file)
            else:
                bb.fatal("File '%s' not found!" % src)
        shutil.copyfile(src, os.path.join(d.getVar('S'), file))
}
addtask prepare_local_auths after do_configure before do_compile
do_prepare_local_auths[vardeps] += "UEFI_SIGN_ENABLE UEFI_SIGN_KEYDIR"

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0600 ${B}/LockDown.efi ${DEPLOYDIR}
    install -m 0600 ${WORKDIR}/lockdown.conf ${DEPLOYDIR}

    if [ "${UEFI_SIGN_ENABLE}" = "1" ]; then
        if ! sbsign --key ${UEFI_SIGN_KEYDIR}/DB.key \
                    --cert ${UEFI_SIGN_KEYDIR}/DB.crt \
                     --output ${WORKDIR}/UnLock-signed.efi \
                    ${B}/UnLock.efi; then
            bbfatal "Failed to sign UnLock.efi"
        fi

        if ! sbverify --cert ${UEFI_SIGN_KEYDIR}/DB.crt \
                    ${WORKDIR}/UnLock-signed.efi; then
            bbfatal "Failed to verify UnLock-signed.efi"
        fi

        install -m 0600 ${WORKDIR}/UnLock-signed.efi ${DEPLOYDIR}
        install -m 0600 ${WORKDIR}/unlock.conf ${DEPLOYDIR}
    fi
}
addtask deploy after do_install before do_build
