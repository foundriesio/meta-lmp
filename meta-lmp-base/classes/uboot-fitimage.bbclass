# U-Boot fitImage support for verified boot, validated by SPL and including
# support for booting ATF, OP-TEE and U-Boot as a normal world payload

inherit kernel-arch

# Share same key as used by U-Boot by default
UBOOT_SPL_SIGN_ENABLE ?= "${UBOOT_SIGN_ENABLE}"
UBOOT_SPL_SIGN_KEYNAME ?= "${UBOOT_SIGN_KEYNAME}"

# Default value for deployment filenames
UBOOT_SPL_DTB_IMAGE ?= "${SPL_BINARYNAME}-${MACHINE}-${PV}-${PR}.dtb"
UBOOT_SPL_DTB_BINARY ?= "${SPL_BINARYNAME}.dtb"
UBOOT_SPL_DTB_SYMLINK ?= "${SPL_BINARYNAME}-${MACHINE}.dtb"
UBOOT_ITB_IMAGE ?= "u-boot-${MACHINE}-${PV}-${PR}.itb"
UBOOT_ITB_BINARY ?= "u-boot.itb"
UBOOT_ITB_SYMLINK ?= "u-boot-${MACHINE}.itb"
UBOOT_ITS_IMAGE ?= "u-boot-${MACHINE}-${PV}-${PR}.its"
UBOOT_ITS_BINARY ?= "u-boot.its"
UBOOT_ITS_SYMLINK ?= "u-boot-${MACHINE}.its"

# fitImage Hash Algo
FIT_HASH_ALG ?= "sha256"
OPTEE_BINARY ?= "tee-pager.bin"
ATF_BINARY ?= "arm-trusted-firmware.bin"
ATF_SUPPORT = "${@bb.utils.contains('EXTRA_IMAGEDEPENDS', 'virtual/trusted-firmware-a', 'true', 'false', d)}"

do_compile[depends] += " virtual/optee-os:do_deploy"
do_compile[depends] += " ${@'virtual/trusted-firmware-a:do_deploy' if d.getVar('ATF_SUPPORT') == 'true' else ''}"

# Assemble U-Boot fitImage
#
# - U-Boot no-dtb binary
# - Signed U-Boot dtb
# - OP-TEE
# - ATF (if enabled)
#
# Only one U-Boot dtb is currently supported, as it needs to provide the
# signature for runtime check
#
# $1 ... .itb filename
# $2 ... U-Boot load address
# $3 ... OP-TEE load address
# $4 ... ATF load address
uboot_fitimage_assemble() {
	ubootloadaddr=${2}
	opteeloadaddr=${3}
	atfloadaddr=${4}

	# u-boot dtb location depends on sign enable
	if [ "${UBOOT_SIGN_ENABLE}" = "1" -a -n "${UBOOT_DTB_BINARY}" ]; then
		uboot_dtb="${DEPLOY_DIR_IMAGE}/${UBOOT_DTB_IMAGE}"
	else
		uboot_dtb="u-boot.dtb"
	fi

	if ${ATF_SUPPORT}; then
		optee_type="standalone"
		config_firmware="atf"
		config_loadables='"uboot", "optee"';
	else
		optee_type="firmware"
		config_firmware="optee"
		config_loadables='"uboot"';
	fi

cat << EOF > u-boot.its
/dts-v1/;

/ {
	description = "U-Boot/SPL fitImage with OP-TEE support";
	#address-cells = <1>;
	images {
		uboot {
			description = "U-Boot no-dtb";
			data = /incbin/("u-boot-nodtb.bin");
			type = "standalone";
			os = "U-Boot";
			arch = "${UBOOT_ARCH}";
			compression = "none";
			load = <${ubootloadaddr}>;
			entry = <${ubootloadaddr}>;
			hash-1 {
				algo = "${FIT_HASH_ALG}";
			};
		};
		ubootfdt {
			description = "U-Boot dtb";
			data = /incbin/("${uboot_dtb}");
			type = "flat_dt";
			compression = "none";
			hash-1 {
				algo = "${FIT_HASH_ALG}";
			};
		};
EOF
	# Add ATF block if ATF is supported by the board
	if ${ATF_SUPPORT}; then
		cat << EOF >> u-boot.its
		atf {
			description = "ARM Trusted Firmware";
			data = /incbin/("${DEPLOY_DIR_IMAGE}/${ATF_BINARY}");
			type = "firmware";
			arch = "${UBOOT_ARCH}";
			os = "arm-trusted-firmware";
			compression = "none";
			load = <${atfloadaddr}>;
			entry = <${atfloadaddr}>;
			hash-1 {
				algo = "${FIT_HASH_ALG}";
			};
		};
EOF
	fi
	cat << EOF >> u-boot.its
		optee {
			description = "OP-TEE";
			data = /incbin/("${DEPLOY_DIR_IMAGE}/optee/${OPTEE_BINARY}");
			type = "${optee_type}";
			arch = "${UBOOT_ARCH}";
			os = "tee";
			compression = "none";
			load = <${opteeloadaddr}>;
			entry = <${opteeloadaddr}>;
			hash-1 {
				algo = "${FIT_HASH_ALG}";
			};
		};
	};
	configurations {
		default = "config-1";
		config-1 {
			description = "OP-TEE with U-Boot in normal world for ${MACHINE}";
			firmware = "${config_firmware}";
			loadables = ${config_loadables};
			fdt = "ubootfdt";
			signature {
				algo = "${FIT_HASH_ALG},rsa2048";
				key-name-hint = "${UBOOT_SPL_SIGN_KEYNAME}";
				sign-images = "firmware", "loadables", "fdt";
			};
		};
	};
};
EOF

	# Assemble the ITB image
	tools/mkimage -f u-boot.its ${1}
}

# Sign U-Boot fitImage
#
# SPL_BINARY needs to be updated to include the new dtb (with public key)
#
# $1 ... .itb filename
uboot_fitimage_sign() {
	if [ "x${UBOOT_SPL_SIGN_ENABLE}" = "x1" ]; then
		tools/mkimage -F -k "${UBOOT_SIGN_KEYDIR}" -K spl/u-boot-spl.dtb -r ${1}
	fi
	cat spl/u-boot-spl-nodtb.bin spl/u-boot-spl.dtb > ${SPL_BINARY}
}

# Needs to happen after concat_dtb, which is a do_deploy prefuncs
do_deploy_prepend() {
	OPTEE_LOAD_ADDR=`cat ${DEPLOY_DIR_IMAGE}/optee/tee-init_load_addr.txt`
	if ${ATF_SUPPORT}; then
		ATF_ELF="${DEPLOY_DIR_IMAGE}/$(basename -s .bin ${ATF_BINARY}).elf"
		ATF_LOAD_ADDR=$(${READELF} -h ${ATF_ELF} | egrep -m 1 -i "entry point.*?0x" | sed -r 's/.*?(0x.*?)/\1/g')
	fi

	if [ -n "${UBOOT_CONFIG}" ]; then
		for config in ${UBOOT_MACHINE}; do
			i=$(expr $i + 1);
			for type in ${UBOOT_CONFIG}; do
				j=$(expr $j + 1);
				if [ $j -eq $i ]; then
					cd ${B}/${config}
					UBOOT_LOAD_ADDR=`grep 'define CONFIG_SYS_TEXT_BASE' u-boot.cfg | cut -d' ' -f 3`
					uboot_fitimage_assemble ${UBOOT_ITB_BINARY} ${UBOOT_LOAD_ADDR} ${OPTEE_LOAD_ADDR} ${ATF_LOAD_ADDR}
					uboot_fitimage_sign ${UBOOT_ITB_BINARY}
					# Make SPL to generate a board-compatible binary via mkimage
					oe_runmake -C ${S} O=${B}/${config} ${SPL_BINARY}
					if [ -f spl/u-boot-spl.dtb ]; then
						install -m 644 spl/u-boot-spl.dtb ${DEPLOYDIR}/${SPL_BINARY}-${MACHINE}-${type}-${PV}-${PR}.dtb
						ln -sf ${SPL_BINARY}-${MACHINE}-${type}-${PV}-${PR}.dtb ${DEPLOYDIR}/${UBOOT_SPL_DTB_SYMLINK}-${type}
						ln -sf ${SPL_BINARY}-${MACHINE}-${type}-${PV}-${PR}.dtb ${DEPLOYDIR}/${UBOOT_SPL_DTB_SYMLINK}
						ln -sf ${SPL_BINARY}-${MACHINE}-${type}-${PV}-${PR}.dtb ${DEPLOYDIR}/${UBOOT_SPL_DTB_BINARY}-${type}
						ln -sf ${SPL_BINARY}-${MACHINE}-${type}-${PV}-${PR}.dtb ${DEPLOYDIR}/${UBOOT_SPL_DTB_BINARY}

					fi
					if [ -f "${UBOOT_ITB_BINARY}" ]; then
						install -m 644 ${UBOOT_ITB_BINARY} ${DEPLOYDIR}/u-boot-${MACHINE}-${type}-${PV}-${PR}.itb
						ln -sf u-boot-${MACHINE}-${type}-${PV}-${PR}.itb ${DEPLOYDIR}/${UBOOT_ITB_SYMLINK}-${type}
						ln -sf u-boot-${MACHINE}-${type}-${PV}-${PR}.itb ${DEPLOYDIR}/${UBOOT_ITB_SYMLINK}
						ln -sf u-boot-${MACHINE}-${type}-${PV}-${PR}.itb ${DEPLOYDIR}/${UBOOT_ITB_BINARY}-${type}
						ln -sf u-boot-${MACHINE}-${type}-${PV}-${PR}.itb ${DEPLOYDIR}/${UBOOT_ITB_BINARY}

						install -m 644 ${UBOOT_ITS_BINARY} ${DEPLOYDIR}/u-boot-${MACHINE}-${type}-${PV}-${PR}.its
						ln -sf u-boot-${MACHINE}-${type}-${PV}-${PR}.its ${DEPLOYDIR}/${UBOOT_ITS_SYMLINK}-${type}
						ln -sf u-boot-${MACHINE}-${type}-${PV}-${PR}.its ${DEPLOYDIR}/${UBOOT_ITS_SYMLINK}
						ln -sf u-boot-${MACHINE}-${type}-${PV}-${PR}.its ${DEPLOYDIR}/${UBOOT_ITS_BINARY}-${type}
						ln -sf u-boot-${MACHINE}-${type}-${PV}-${PR}.its ${DEPLOYDIR}/${UBOOT_ITS_BINARY}
					fi
				fi
			done
			unset j
		done
		unset i
	else
		cd ${B}
		UBOOT_LOAD_ADDR=`grep 'define CONFIG_SYS_TEXT_BASE' u-boot.cfg | cut -d' ' -f 3`
		uboot_fitimage_assemble ${UBOOT_ITB_BINARY} ${UBOOT_LOAD_ADDR} ${OPTEE_LOAD_ADDR} ${ATF_LOAD_ADDR}
		uboot_fitimage_sign ${UBOOT_ITB_BINARY}
		# Make SPL to generate a board-compatible binary via mkimage
		oe_runmake -C ${S} O=${B} ${SPL_BINARY}
		if [ -f spl/u-boot-spl.dtb ]; then
			install -m 644 spl/u-boot-spl.dtb ${DEPLOYDIR}/${UBOOT_SPL_DTB_IMAGE}
			ln -sf ${UBOOT_SPL_DTB_IMAGE} ${DEPLOYDIR}/${UBOOT_SPL_DTB_SYMLINK}
			ln -sf ${UBOOT_SPL_DTB_IMAGE} ${DEPLOYDIR}/${UBOOT_SPL_DTB_BINARY}
		fi
		if [ -f "${UBOOT_ITB_BINARY}" ]; then
			install -m 644 ${UBOOT_ITB_BINARY} ${DEPLOYDIR}/${UBOOT_ITB_IMAGE}
			ln -sf ${UBOOT_ITB_IMAGE} ${DEPLOYDIR}/${UBOOT_ITB_SYMLINK}
			ln -sf ${UBOOT_ITB_IMAGE} ${DEPLOYDIR}/${UBOOT_ITB_BINARY}

			install -m 644 ${UBOOT_ITS_BINARY} ${DEPLOYDIR}/${UBOOT_ITS_IMAGE}
			ln -sf ${UBOOT_ITS_IMAGE} ${DEPLOYDIR}/${UBOOT_ITS_SYMLINK}
			ln -sf ${UBOOT_ITS_IMAGE} ${DEPLOYDIR}/${UBOOT_ITS_BINARY}
		fi
	fi
}
