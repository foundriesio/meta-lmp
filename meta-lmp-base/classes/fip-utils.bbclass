DEPENDS += "tf-a-tools-native"

# Define default TF-A FIP namings
FIP_BASENAME ?= "fip"
FIP_SUFFIX   ?= "bin"

# Set default TF-A FIP config
FIP_CONFIG ?= ""

# Default FIP config:
#   There are two options implemented to select two different firmware and each
#   FIP_CONFIG should configure one: 'tfa' or 'optee'
FIP_CONFIG[tfa-fw] ?= "tfa"
FIP_CONFIG[tee-fw] ?= "optee"

# Init BL31 config
FIP_BL31_ENABLE ?= ""

# Set CERTTOOL binary name to use
CERTTOOL ?= "cert_create"
# Set FIPTOOL binary name to use
FIPTOOL ?= "fiptool"

# Default FIP file names and suffixes
FIP_BL31        ?= "tf-a-bl31"
FIP_BL31_SUFFIX ?= "bin"
FIP_TFA        ?= "tf-a-bl32"
FIP_TFA_SUFFIX ?= "bin"
FIP_TFA_DTB        ?= "bl32"
FIP_TFA_DTB_SUFFIX ?= "dtb"
FIP_FW_CONFIG ?= "fw-config"
FIP_FW_CONFIG_SUFFIX ?= "dtb"
FIP_OPTEE_HEADER   ?= "tee-header_v2"
FIP_OPTEE_PAGER    ?= "tee-pager_v2"
FIP_OPTEE_PAGEABLE ?= "tee-pageable_v2"
FIP_OPTEE_SUFFIX   ?= "bin"
FIP_UBOOT        ?= "u-boot-nodtb"
FIP_UBOOT_SUFFIX ?= "bin"
FIP_UBOOT_DTB        ?= "u-boot"
FIP_UBOOT_DTB_SUFFIX ?= "dtb"
FIP_UBOOT_CONFIG ?= "trusted"
# U-Boot boot cmd script
FIP_BOOT_ITB_BINARY ?= "boot.itb"
FIP_BOOT_ITB_UUID ?= "c75cd5f6-1f9c-11ed-861d-0242ac120002"
# Integrate boot.itb script into FIP image for OTA setups
FIP_BOOT_ITB_CONF ?= "${@bb.utils.contains('PREFERRED_PROVIDER_u-boot-default-script', 'u-boot-ostree-scr-fit', '--blob uuid=${FIP_BOOT_ITB_UUID},file=${FIP_DEPLOYDIR_BOOT_ITB}/${FIP_BOOT_ITB_BINARY}', '', d)}"

# Configure default folder path for binaries to package
FIP_DEPLOYDIR_FIP    ?= "${DEPLOYDIR}/fip"
FIP_DEPLOYDIR_BL31   ?= "${DEPLOYDIR}/arm-trusted-firmware/bl31"
FIP_DEPLOYDIR_TFA    ?= "${DEPLOYDIR}/arm-trusted-firmware/bl32"
FIP_DEPLOYDIR_FWCONF ?= "${DEPLOYDIR}/arm-trusted-firmware/fwconfig"
FIP_DEPLOYDIR_OPTEE  ?= "${DEPLOY_DIR}/images/${MACHINE}/optee"
FIP_DEPLOYDIR_UBOOT  ?= "${DEPLOY_DIR}/images/${MACHINE}/u-boot"
FIP_DEPLOYDIR_BOOT_ITB  ?= "${DEPLOY_DIR}/images/${MACHINE}"

# Set default configuration to allow FIP signing
FIP_SIGN_ENABLE ?= "${@bb.utils.contains('TF_A_SIGN_ENABLE', '1', '1', '', d)}"
FIP_SIGN_KEY_PATH ?= "${TF_A_SIGN_KEY_PATH}"

# Define FIP dependency build
FIP_DEPENDS += "virtual/bootloader"
FIP_DEPENDS += "${@bb.utils.contains('MACHINE_FEATURES', 'optee', 'virtual/optee-os', '', d)}"
FIP_DEPENDS += "u-boot-default-script"
FIP_DEPENDS:class-nativesdk = ""

python () {
    import re

    # Make sure that deploy class is configured
    if not bb.data.inherits_class('deploy', d):
         bb.fatal("The fip-utils class needs the deploy class to be configured on recipe side.")

    # Manage FIP binary dependencies
    fip_depends = (d.getVar('FIP_DEPENDS') or "").split()
    if len(fip_depends) > 0:
        for depend in fip_depends:
            d.appendVarFlag('do_deploy', 'depends', ' %s:do_deploy' % depend)

    # Manage FIP config settings
    fipconfigflags = d.getVarFlags('FIP_CONFIG')
    # The "doc" varflag is special, we don't want to see it here
    fipconfigflags.pop('doc', None)
    fipconfig = (d.getVar('FIP_CONFIG') or "").split()
    if not fipconfig:
        raise bb.parse.SkipRecipe("FIP_CONFIG must be set in the %s machine configuration." % d.getVar("MACHINE"))
    if (d.getVar('FIP_BL32_CONF') or "").split():
        raise bb.parse.SkipRecipe("You cannot use FIP_BL32_CONF as it is internal to FIP_CONFIG var expansion.")
    if (d.getVar('FIP_DEVICETREE') or "").split():
        raise bb.parse.SkipRecipe("You cannot use FIP_DEVICETREE as it is internal to FIP_CONFIG var expansion.")
    if len(fipconfig) > 0:
        for config in fipconfig:
            for f, v in fipconfigflags.items():
                if config == f:
                    # Make sure to get var flag properly expanded
                    v = d.getVarFlag('FIP_CONFIG', config)
                    if not v.strip():
                        bb.fatal('[FIP_CONFIG] Missing configuration for %s config' % config)
                    items = v.split(',')
                    if items[0] and len(items) > 2:
                        raise bb.parse.SkipRecipe('Only <BL32_CONF> and <DT_CONFIG> can be specified!')
                    # Set internal vars
                    bb.debug(1, "Appending '%s' to FIP_BL32_CONF" % items[0])
                    d.appendVar('FIP_BL32_CONF', items[0] + ',')
                    bb.debug(1, "Appending '%s' to FIP_DEVICETREE" % items[1])
                    d.appendVar('FIP_DEVICETREE', items[1] + ',')
                    break
    if d.getVar('FIP_SIGN_ENABLE') == '1':
        signature_key = d.getVar('FIP_SIGN_KEY_PATH')
        if not signature_key:
            bb.fatal("Please make sure to configure \"FIP_SIGN_KEY_PATH\" or \"TF_A_SIGN_KEY_PATH\" to a valid key")
}

# Deploy the fip binary for current target
do_deploy:append:class-target() {
    install -d ${DEPLOYDIR}
    install -d ${FIP_DEPLOYDIR_FIP}

    unset i
    for config in ${FIP_CONFIG}; do
        i=$(expr $i + 1)
        bl32_conf=$(echo ${FIP_BL32_CONF} | cut -d',' -f${i})
        dt_config=$(echo ${FIP_DEVICETREE} | cut -d',' -f${i})
        for dt in ${dt_config}; do
            # Init soc suffix
            soc_suffix=""
            if [ -n "${TF_A_SOC_NAME}" ]; then
                for soc in ${TF_A_SOC_NAME}; do
                    [ "$(echo ${dt} | grep -c ${soc})" -eq 1 ] && soc_suffix="-${soc}"
                done
            fi
            # Init FIP fw-config settings
            [ -f "${FIP_DEPLOYDIR_FWCONF}/${dt}-${FIP_FW_CONFIG}-${config}.${FIP_FW_CONFIG_SUFFIX}" ] || bbfatal "Missing ${dt}-${FIP_FW_CONFIG}-${config}.${FIP_FW_CONFIG_SUFFIX} file in folder: ${FIP_DEPLOYDIR_FWCONF}"
            FIP_FWCONFIG="--fw-config ${FIP_DEPLOYDIR_FWCONF}/${dt}-${FIP_FW_CONFIG}-${config}.${FIP_FW_CONFIG_SUFFIX}"
            # Init FIP hw-config settings
            [ -f "${FIP_DEPLOYDIR_UBOOT}/${FIP_UBOOT_DTB}-${dt}-${FIP_UBOOT_CONFIG}.${FIP_UBOOT_DTB_SUFFIX}" ] || bbfatal "Missing ${FIP_UBOOT_DTB}-${dt}-${FIP_UBOOT_CONFIG}.${FIP_UBOOT_DTB_SUFFIX} file in folder: ${FIP_DEPLOYDIR_UBOOT}"
            FIP_HWCONFIG="--hw-config ${FIP_DEPLOYDIR_UBOOT}/${FIP_UBOOT_DTB}-${dt}-${FIP_UBOOT_CONFIG}.${FIP_UBOOT_DTB_SUFFIX}"
            # Init FIP nt-fw config
            [ -f "${FIP_DEPLOYDIR_UBOOT}/${FIP_UBOOT}${soc_suffix}.${FIP_UBOOT_SUFFIX}" ] || bbfatal "Missing ${FIP_UBOOT}${soc_suffix}.${FIP_UBOOT_SUFFIX} file in folder: ${FIP_DEPLOYDIR_UBOOT}"
            FIP_NTFW="--nt-fw ${FIP_DEPLOYDIR_UBOOT}/${FIP_UBOOT}${soc_suffix}.${FIP_UBOOT_SUFFIX}"
            # Init FIP bl31 settings
            if [ "${FIP_BL31_ENABLE}" = "1" ]; then
                # Check for files
                [ -f "${FIP_DEPLOYDIR_BL31}/${FIP_BL31}${soc_suffix}.${FIP_BL31_SUFFIX}" ] || bbfatal "No ${FIP_BL31}${soc_suffix}.${FIP_BL31_SUFFIX} file in folder: ${FIP_DEPLOYDIR_BL31}"
                # Set FIP_BL31CONF
                FIP_BL31CONF="--soc-fw ${FIP_DEPLOYDIR_BL31}/${FIP_BL31}${soc_suffix}.${FIP_BL31_SUFFIX}"
            else
                FIP_BL31CONF=""
            fi
            # Init FIP extra conf settings
            if [ "${bl32_conf}" = "tfa" ]; then
                # Check for files
                [ -f "${FIP_DEPLOYDIR_TFA}/${FIP_TFA}${soc_suffix}.${FIP_TFA_SUFFIX}" ] || bbfatal "No ${FIP_TFA}${soc_suffix}.${FIP_TFA_SUFFIX} file in folder: ${FIP_DEPLOYDIR_TFA}"
                [ -f "${FIP_DEPLOYDIR_TFA}/${dt}-${FIP_TFA_DTB}.${FIP_TFA_DTB_SUFFIX}" ] || bbfatal "No ${dt}-${FIP_TFA_DTB}.${FIP_TFA_DTB_SUFFIX} file in folder: ${FIP_DEPLOYDIR_TFA}"
                # Set FIP_EXTRACONF
                FIP_EXTRACONF="\
                    --tos-fw ${FIP_DEPLOYDIR_TFA}/${FIP_TFA}${soc_suffix}.${FIP_TFA_SUFFIX} \
                    --tos-fw-config ${FIP_DEPLOYDIR_TFA}/${dt}-${FIP_TFA_DTB}.${FIP_TFA_DTB_SUFFIX} \
                    "
            elif [ "${bl32_conf}" = "optee" ]; then
                # Check for files
                [ -f "${FIP_DEPLOYDIR_OPTEE}/${FIP_OPTEE_HEADER}-${dt}.${FIP_OPTEE_SUFFIX}" ] || bbfatal "Missing ${FIP_OPTEE_HEADER}-${dt}.${FIP_OPTEE_SUFFIX} file in folder: ${FIP_DEPLOYDIR_OPTEE}"
                [ -f "${FIP_DEPLOYDIR_OPTEE}/${FIP_OPTEE_PAGER}-${dt}.${FIP_OPTEE_SUFFIX}" ] || bbfatal "Missing ${FIP_OPTEE_PAGER}-${dt}.${FIP_OPTEE_SUFFIX} file in folder: ${FIP_DEPLOYDIR_OPTEE}"
                [ -f "${FIP_DEPLOYDIR_OPTEE}/${FIP_OPTEE_PAGEABLE}-${dt}.${FIP_OPTEE_SUFFIX}" ] || bbfatal "Missing ${FIP_OPTEE_PAGEABLE}-${dt}.${FIP_OPTEE_SUFFIX} file in folder: ${FIP_DEPLOYDIR_OPTEE}"
                # Set FIP_EXTRACONF
                FIP_EXTRACONF="\
                    --tos-fw ${FIP_DEPLOYDIR_OPTEE}/${FIP_OPTEE_HEADER}-${dt}.${FIP_OPTEE_SUFFIX} \
                    --tos-fw-extra1 ${FIP_DEPLOYDIR_OPTEE}/${FIP_OPTEE_PAGER}-${dt}.${FIP_OPTEE_SUFFIX} \
                    --tos-fw-extra2 ${FIP_DEPLOYDIR_OPTEE}/${FIP_OPTEE_PAGEABLE}-${dt}.${FIP_OPTEE_SUFFIX} \
                    "
            else
                bbfatal "Wrong configuration '${bl32_conf}' found in FIP_CONFIG for ${config} config."
            fi
            # Init certificate settings
            if [ "${FIP_SIGN_ENABLE}" = "1" ]; then
                sign_key="${FIP_SIGN_KEY_PATH}"
                if [ -z "${sign_key}" ]; then
                    bbfatal "Please make sure to configure \"FIP_SIGN_KEY_PATH\" var to signing key file."
                fi
                FIP_CERTCONF="\
                    --tb-fw-cert ${WORKDIR}/tb_fw.crt \
                    --trusted-key-cert ${WORKDIR}/trusted_key.crt \
                    --nt-fw-cert ${WORKDIR}/nt_fw_content.crt \
                    --nt-fw-key-cert ${WORKDIR}/nt_fw_key.crt \
                    --tos-fw-cert ${WORKDIR}/tos_fw_content.crt \
                    --tos-fw-key-cert ${WORKDIR}/tos_fw_key.crt \
                    "
                # Need fake bl2 binary to generate certificates
                touch ${WORKDIR}/bl2-fake.bin
                # Generate certificates
                ${CERTTOOL} -n --tfw-nvctr 0 --ntfw-nvctr 0 --key-alg ecdsa --hash-alg sha256 \
                        --rot-key ${sign_key} \
                        ${FIP_FWCONFIG} \
                        ${FIP_HWCONFIG} \
                        ${FIP_NTFW} \
                        ${FIP_EXTRACONF} \
                        ${FIP_CERTCONF} \
                        --tb-fw ${WORKDIR}/bl2-fake.bin
                # Remove fake bl2 binary
                rm -f ${WORKDIR}/bl2-fake.bin
            else
                FIP_CERTCONF=""
            fi
            # Generate FIP binary
            bbnote "${FIPTOOL} create \
                            ${FIP_FWCONFIG} \
                            ${FIP_HWCONFIG} \
                            ${FIP_NTFW} \
                            ${FIP_BL31CONF} \
                            ${FIP_EXTRACONF} \
                            ${FIP_BOOT_ITB_CONF} \
                            ${FIP_CERTCONF} \
                            ${FIP_DEPLOYDIR_FIP}/${FIP_BASENAME}-${dt}-${config}.${FIP_SUFFIX}"
            ${FIPTOOL} create \
                            ${FIP_FWCONFIG} \
                            ${FIP_HWCONFIG} \
                            ${FIP_NTFW} \
                            ${FIP_BL31CONF} \
                            ${FIP_EXTRACONF} \
                            ${FIP_BOOT_ITB_CONF} \
                            ${FIP_CERTCONF} \
                            ${FIP_DEPLOYDIR_FIP}/${FIP_BASENAME}-${dt}-${config}.${FIP_SUFFIX}
        done
    done
}
