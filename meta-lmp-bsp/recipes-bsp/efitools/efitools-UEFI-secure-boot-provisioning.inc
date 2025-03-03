SSTATE_ALLOW_OVERLAP_FILES += "${DEPLOY_DIR_IMAGE}/UnLock-signed.efi"

SRC_URI += " \
    file://lockdown.conf \
    file://unlock.patch \
    file://unlock.conf \
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
