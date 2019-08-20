# U-Boot fitImage support for verified boot, validated by SPL and including
# support for booting OP-TEE and U-Boot as a normal world payload

# Share same key as used by U-Boot by default
UBOOT_SPL_SIGN_ENABLE ?= "${UBOOT_SIGN_ENABLE}"
UBOOT_SPL_SIGN_KEYNAME ?= "${UBOOT_SIGN_KEYNAME}"

# Default value for deployment filenames
UBOOT_SPL_DTB_IMAGE ?= "${SPL_BINARY}-${MACHINE}-${PV}-${PR}.dtb"
UBOOT_SPL_DTB_BINARY ?= "${SPL_BINARY}.dtb"
UBOOT_SPL_DTB_SYMLINK ?= "${SPL_BINARY}-${MACHINE}.dtb"
UBOOT_ITB_IMAGE ?= "u-boot-${MACHINE}-${PV}-${PR}.itb"
UBOOT_ITB_BINARY ?= "u-boot.itb"
UBOOT_ITB_SYMLINK ?= "u-boot-${MACHINE}.itb"

# fitImage Hash Algo
FIT_HASH_ALG ?= "sha256"
OPTEE_BINARY ?= "tee-pager.bin"

do_compile[depends] += " optee-os:do_deploy"

# Assemble U-Boot fitImage
#
# - U-Boot no-dtb binary
# - Signed U-Boot dtb
# - OP-TEE
#
# Only one U-Boot dtb is currently supported, as it needs to provide the
# signature for runtime check
#
# $1 ... .itb filename
# $2 ... U-Boot load address
# $3 ... OP-TEE load address
uboot_fitimage_assemble() {
	ubootloadaddr=${2}
	opteeloadaddr=${3}

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
			hash-1 {
				algo = "${FIT_HASH_ALG}";
			};
		};
		ubootfdt {
			description = "U-Boot dtb";
			data = /incbin/("${DEPLOY_DIR_IMAGE}/${UBOOT_DTB_IMAGE}");
			type = "flat_dt";
			compression = "none";
			hash-1 {
				algo = "${FIT_HASH_ALG}";
			};
		};
		optee {
			description = "OP-TEE";
			data = /incbin/("${DEPLOY_DIR_IMAGE}/optee/${OPTEE_BINARY}");
			type = "firmware";
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
			description = "OP-TEE with U-Boot in normal world";
			firmware = "optee";
			loadables = "uboot";
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

deploy_itb_helper() {
        if [ -f spl/u-boot-spl.dtb ]; then
                install -m 644 spl/u-boot-spl.dtb ${DEPLOYDIR}/${UBOOT_SPL_DTB_IMAGE}
                ln -sf ${UBOOT_SPL_DTB_IMAGE} ${DEPLOYDIR}/${UBOOT_SPL_DTB_SYMLINK}
                ln -sf ${UBOOT_SPL_DTB_IMAGE} ${DEPLOYDIR}/${UBOOT_SPL_DTB_BINARY}
        fi
        if [ -f "${UBOOT_ITB_BINARY}" ]; then
                install -m 644 ${UBOOT_ITB_BINARY} ${DEPLOYDIR}/${UBOOT_ITB_IMAGE}
                ln -sf ${UBOOT_ITB_IMAGE} ${DEPLOYDIR}/${UBOOT_ITB_SYMLINK}
                ln -sf ${UBOOT_ITB_IMAGE} ${DEPLOYDIR}/${UBOOT_ITB_BINARY}
        fi
}

# Needs to happen after concat_dtb, which is a do_deploy prefuncs
do_deploy_prepend() {
	OPTEE_LOAD_ADDR=`cat ${DEPLOY_DIR_IMAGE}/optee/tee-init_load_addr.txt`

	if [ -n "${UBOOT_CONFIG}" ]; then
		for config in ${UBOOT_MACHINE}; do
			cd ${B}/${config}
			UBOOT_LOAD_ADDR=`grep CONFIG_SYS_TEXT_BASE u-boot.cfg | cut -d' ' -f 3`
			uboot_fitimage_assemble ${UBOOT_ITB_BINARY} ${UBOOT_LOAD_ADDR} ${OPTEE_LOAD_ADDR}
			uboot_fitimage_sign ${UBOOT_ITB_BINARY}
			# Make SPL to generate a board-compatible binary via mkimage
			oe_runmake -C ${S} O=${B}/${config} SPL
			deploy_itb_helper
		done
	else
		cd ${B}
		UBOOT_LOAD_ADDR=`grep CONFIG_SYS_TEXT_BASE u-boot.cfg | cut -d' ' -f 3`
		uboot_fitimage_assemble ${UBOOT_ITB_BINARY} ${UBOOT_LOAD_ADDR} ${OPTEE_LOAD_ADDR}
		uboot_fitimage_sign ${UBOOT_ITB_BINARY}
		# Make SPL to generate a board-compatible binary via mkimage
		oe_runmake -C ${S} O=${B} SPL
		deploy_itb_helper
	fi
}
