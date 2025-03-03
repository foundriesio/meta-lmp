# Linux microPlatform extensions to the upstream OE-core kernel-fitimage class

inherit kernel-fitimage

# Default value for deployment filenames
FIT_LOADABLES ?= ""

# Recovery
INITRAMFS_RECOVERY_IMAGE ?= ""
INITRAMFS_RECOVERY_IMAGE_NAME ?= "${@['${INITRAMFS_RECOVERY_IMAGE}-${MACHINE}', ''][d.getVar('INITRAMFS_RECOVERY_IMAGE') == '']}"

python __anonymous () {
        recovery = d.getVar('INITRAMFS_RECOVERY_IMAGE')
        if recovery:
            d.appendVarFlag('do_assemble_fitimage_initramfs', 'depends', ' ${INITRAMFS_RECOVERY_IMAGE}:do_image_complete')
}

#
# Emit the fitImage ITS kernel section
#
# $1 ... .its filename
# $2 ... Image counter
# $3 ... Path to kernel image
# $4 ... Compression type
fitimage_emit_section_kernel() {

	kernel_csum="${FIT_HASH_ALG}"
	kernel_sign_algo="${FIT_SIGN_ALG}"
	kernel_sign_keyname="${UBOOT_SIGN_IMG_KEYNAME}"

	ENTRYPOINT="${UBOOT_ENTRYPOINT}"
	if [ -n "${UBOOT_ENTRYSYMBOL}" ]; then
		ENTRYPOINT=`${HOST_PREFIX}nm vmlinux | \
			awk '$3=="${UBOOT_ENTRYSYMBOL}" {print "0x"$1;exit}'`
	fi

	cat << EOF >> ${1}
                kernel-${2} {
                        description = "Linux kernel";
                        data = /incbin/("${3}");
                        type = "${UBOOT_MKIMAGE_KERNEL_TYPE}";
                        arch = "${UBOOT_ARCH}";
                        os = "linux";
                        compression = "${4}";
                        load = <${UBOOT_LOADADDRESS}>;
                        entry = <${ENTRYPOINT}>;
                        hash-1 {
                                algo = "${kernel_csum}";
                        };
                };
EOF

	if [ "${UBOOT_SIGN_ENABLE}" = "1" -a "${FIT_SIGN_INDIVIDUAL}" = "1" -a -n "${kernel_sign_keyname}" ] ; then
		sed -i '$ d' ${1}
		cat << EOF >> ${1}
                        signature-1 {
                                algo = "${kernel_csum},${kernel_sign_algo}";
                                key-name-hint = "${kernel_sign_keyname}";
                        };
                };
EOF
	fi
}

#
# Emit the fitImage ITS DTB section
#
# $1 ... .its filename
# $2 ... Image counter
# $3 ... Path to DTB image
fitimage_emit_section_dtb() {

	dtb_csum="${FIT_HASH_ALG}"
	dtb_sign_algo="${FIT_SIGN_ALG}"
	dtb_sign_keyname="${UBOOT_SIGN_IMG_KEYNAME}"

	dtb_loadline=""
	dtb_ext=${DTB##*.}
	if [ "${dtb_ext}" = "dtbo" ]; then
		if [ -n "${UBOOT_DTBO_LOADADDRESS}" ]; then
			dtb_loadline="load = <${UBOOT_DTBO_LOADADDRESS}>;"
		fi
	elif [ -n "${UBOOT_DTB_LOADADDRESS}" ]; then
		dtb_loadline="load = <${UBOOT_DTB_LOADADDRESS}>;"
	fi
	cat << EOF >> ${1}
                fdt-${2} {
                        description = "Flattened Device Tree blob";
                        data = /incbin/("${3}");
                        type = "flat_dt";
                        arch = "${UBOOT_ARCH}";
                        compression = "none";
                        ${dtb_loadline}
                        hash-1 {
                                algo = "${dtb_csum}";
                        };
                };
EOF

	if [ "${UBOOT_SIGN_ENABLE}" = "1" -a "${FIT_SIGN_INDIVIDUAL}" = "1" -a -n "${dtb_sign_keyname}" ] ; then
		sed -i '$ d' ${1}
		cat << EOF >> ${1}
                        signature-1 {
                                algo = "${dtb_csum},${dtb_sign_algo}";
                                key-name-hint = "${dtb_sign_keyname}";
                        };
                };
EOF
	fi
}

#
# Emit the fitImage ITS u-boot script section
#
# $1 ... .its filename
# $2 ... Image counter
# $3 ... Path to boot script image
fitimage_emit_section_boot_script() {

	bootscr_csum="${FIT_HASH_ALG}"
	bootscr_sign_algo="${FIT_SIGN_ALG}"
	bootscr_sign_keyname="${UBOOT_SIGN_IMG_KEYNAME}"

	cat << EOF >> ${1}
                bootscr-${2} {
                        description = "U-boot script";
                        data = /incbin/("${3}");
                        type = "script";
                        arch = "${UBOOT_ARCH}";
                        compression = "none";
                        hash-1 {
                                algo = "${bootscr_csum}";
                        };
                };
EOF

	if [ "${UBOOT_SIGN_ENABLE}" = "1" -a "${FIT_SIGN_INDIVIDUAL}" = "1" -a -n "${bootscr_sign_keyname}" ] ; then
		sed -i '$ d' ${1}
		cat << EOF >> ${1}
                        signature-1 {
                                algo = "${bootscr_csum},${bootscr_sign_algo}";
                                key-name-hint = "${bootscr_sign_keyname}";
                        };
                };
EOF
	fi
}

#
# Emit the fitImage ITS setup section
#
# $1 ... .its filename
# $2 ... Image counter
# $3 ... Path to setup image
fitimage_emit_section_setup() {

	setup_csum="${FIT_HASH_ALG}"

	cat << EOF >> ${1}
                setup-${2} {
                        description = "Linux setup.bin";
                        data = /incbin/("${3}");
                        type = "x86_setup";
                        arch = "${UBOOT_ARCH}";
                        os = "linux";
                        compression = "none";
                        load = <0x00090000>;
                        entry = <0x00090000>;
                        hash-1 {
                                algo = "${setup_csum}";
                        };
                };
EOF
}

#
# Emit the fitImage ITS ramdisk section
#
# $1 ... .its filename
# $2 ... Image counter
# $3 ... Ramdisk image name
# $4 ... Path to ramdisk image
fitimage_emit_section_ramdisk() {

	ramdisk_csum="${FIT_HASH_ALG}"
	ramdisk_sign_algo="${FIT_SIGN_ALG}"
	ramdisk_sign_keyname="${UBOOT_SIGN_IMG_KEYNAME}"
	ramdisk_loadline=""
	ramdisk_entryline=""

	if [ -n "${UBOOT_RD_LOADADDRESS}" ]; then
		ramdisk_loadline="load = <${UBOOT_RD_LOADADDRESS}>;"
	fi
	if [ -n "${UBOOT_RD_ENTRYPOINT}" ]; then
		ramdisk_entryline="entry = <${UBOOT_RD_ENTRYPOINT}>;"
	fi

	cat << EOF >> ${1}
                ramdisk-${2} {
                        description = "${3}";
                        data = /incbin/("${4}");
                        type = "ramdisk";
                        arch = "${UBOOT_ARCH}";
                        os = "linux";
                        compression = "none";
                        ${ramdisk_loadline}
                        ${ramdisk_entryline}
                        hash-1 {
                                algo = "${ramdisk_csum}";
                        };
                };
EOF

	if [ "${UBOOT_SIGN_ENABLE}" = "1" -a "${FIT_SIGN_INDIVIDUAL}" = "1" -a -n "${ramdisk_sign_keyname}" ] ; then
		sed -i '$ d' ${1}
		cat << EOF >> ${1}
                        signature-1 {
                                algo = "${ramdisk_csum},${ramdisk_sign_algo}";
                                key-name-hint = "${ramdisk_sign_keyname}";
                        };
                };
EOF
	fi
}

#
# Emit the fitImage ITS configuration section
#
# $1 ... .its filename
# $2 ... Linux kernel ID
# $3 ... DTB image name
# $4 ... ramdisk ID
# $5 ... u-boot script ID
# $6 ... config ID
# $7 ... loadable ID (LmP specific)
# $8 ... default flag
# $9 ... default DTB image name
fitimage_emit_section_config() {

	conf_csum="${FIT_HASH_ALG}"
	conf_sign_algo="${FIT_SIGN_ALG}"
	conf_padding_algo="${FIT_PAD_ALG}"
	if [ "${UBOOT_SIGN_ENABLE}" = "1" ] ; then
		conf_sign_keyname="${UBOOT_SIGN_KEYNAME}"
	fi

	its_file="${1}"
	kernel_id="${2}"
	dtb_image="${3}"
	ramdisk_id="${4}"
	bootscr_id="${5}"
	config_id="${6}"
	loadable_id="${7}"
	default_flag="${8}"
	default_dtb_image="${9}"

	# Test if we have any DTBs at all
	sep=""
	conf_desc=""
	conf_node="conf-"
	kernel_line=""
	fdt_line=""
	ramdisk_line=""
	bootscr_line=""
	setup_line=""
	loadable_line=""
	default_line=""
	compatible_line=""

	dtb_image_sect=$(symlink_points_below $dtb_image "${EXTERNAL_KERNEL_DEVICETREE}")
	if [ -z "$dtb_image_sect" ]; then
		dtb_image_sect=$dtb_image
	fi

	dtb_path="${EXTERNAL_KERNEL_DEVICETREE}/${dtb_image_sect}"
	if [ -f "$dtb_path" ] || [ -L "$dtb_path" ]; then
		compat=$(fdtget -t s "$dtb_path" / compatible | sed 's/ /", "/g')
		if [ -n "$compat" ]; then
			compatible_line="compatible = \"$compat\";"
		fi
	fi

	dtb_image=$(echo $dtb_image | tr '/' '_')
	dtb_image_sect=$(echo "${dtb_image_sect}" | tr '/' '_')

	# conf node name is selected based on dtb ID if it is present,
	# otherwise its selected based on kernel ID
	if [ -n "${dtb_image}" ]; then
		conf_node=$conf_node${dtb_image}
	else
		conf_node=$conf_node${kernel_id}
	fi

	if [ -n "${kernel_id}" ]; then
		conf_desc="Linux kernel"
		sep=", "
		kernel_line="kernel = \"kernel-${kernel_id}\";"
	fi

	if [ -n "${dtb_image}" ]; then
		conf_desc="${conf_desc}${sep}FDT blob"
		sep=", "
		fdt_line="fdt = \"fdt-${dtb_image_sect}\";"
	fi

	if [ -n "${ramdisk_id}" ]; then
		conf_desc="${conf_desc}${sep}ramdisk"
		sep=", "
		ramdisk_line="ramdisk = \"ramdisk-${ramdisk_id}\";"
	fi

	if [ -n "${bootscr_id}" ]; then
		conf_desc="${conf_desc}${sep}u-boot script"
		sep=", "
		bootscr_line="bootscr = \"bootscr-${bootscr_id}\";"
	fi

	if [ -n "${config_id}" ]; then
		conf_desc="${conf_desc}${sep}setup"
		sep=", "
		setup_line="setup = \"setup-${config_id}\";"
	fi

	if [ -n "${loadable_id}" ]; then
		loadable_counter=0
		for LOADABLE in ${loadable_id}; do
			if [ -e ${DEPLOY_DIR_IMAGE}/${LOADABLE} ]; then
				loadable_counter=`expr ${loadable_counter} + 1`
				if [ -z "${loadable_line}" ]; then
					conf_desc="${conf_desc}${sep}loadables"
				fi
				loadable_line="${loadable_line}loadable_${loadable_counter} = \"loadable-${LOADABLE}\"; "
			fi
		done
	fi

	if [ "${default_flag}" = "1" ]; then
		# default node is selected based on dtb ID if it is present
		if [ -n "${dtb_image}" ]; then
			# Select default node as user specified dtb when
			# multiple dtb exists.
			if [ -n "${default_dtb_image}" ]; then
				default_line="default = \"conf-${default_dtb_image}\";"
			else
				default_line="default = \"conf-${dtb_image}\";"
			fi
		else
			default_line="default = \"conf-${kernel_id}\";"
		fi
	fi

	cat << EOF >> ${its_file}
                ${default_line}
                $conf_node {
                        description = "${default_flag} ${conf_desc}";
                        ${compatible_line}
                        ${kernel_line}
                        ${fdt_line}
                        ${ramdisk_line}
                        ${bootscr_line}
                        ${setup_line}
                        ${loadable_line}
                        hash-1 {
                                algo = "${conf_csum}";
                        };
EOF

	if [ ! -z "${conf_sign_keyname}" ] ; then

		sign_line="sign-images = "
		sep=""

		if [ -n "${kernel_id}" ]; then
			sign_line="${sign_line}${sep}\"kernel\""
			sep=", "
		fi

		if [ -n "${dtb_image}" ]; then
			sign_line="${sign_line}${sep}\"fdt\""
			sep=", "
		fi

		if [ -n "${ramdisk_id}" ]; then
			sign_line="${sign_line}${sep}\"ramdisk\""
			sep=", "
		fi

		if [ -n "${bootscr_id}" ]; then
			sign_line="${sign_line}${sep}\"bootscr\""
			sep=", "
		fi

		if [ -n "${config_id}" ]; then
			sign_line="${sign_line}${sep}\"setup\""
		fi

		if [ -n "${loadable_id}" ]; then
			loadable_counter=0
			for LOADABLE in ${loadable_id}; do
				if [ -e ${DEPLOY_DIR_IMAGE}/${LOADABLE} ]; then
					loadable_counter=`expr ${loadable_counter} + 1`
					sign_line="${sign_line}${sep}\"loadable_${loadable_counter}\""
				fi
			done
		fi

		sign_line="${sign_line};"

		cat << EOF >> ${its_file}
                        signature-1 {
                                algo = "${conf_csum},${conf_sign_algo}";
                                key-name-hint = "${conf_sign_keyname}";
                                padding = "$conf_padding_algo";
                                ${sign_line}
                        };
EOF
	fi

	cat << EOF >> ${its_file}
                };
EOF
}

#
# Emit the fitImage ITS loadables section
#
# $1 ... .its filename
# $2 ... Image name
# $3 ... Path to loadable image
fitimage_emit_section_loadable() {

	loadable_csum="${FIT_HASH_ALG}"

	cat << EOF >> ${1}
                loadable-${2} {
                        description = "Loadable";
                        data = /incbin/("${3}");
                        type = "loadable";
                        arch = "${UBOOT_ARCH}";
                        compression = "none";
                        hash-1 {
                                algo = "${loadable_csum=}";
                        };
                };
EOF
}

#
# Assemble fitImage
#
# $1 ... .its filename
# $2 ... fitImage name
# $3 ... include ramdisk
# $4 ... ramdisk name
# $5 ... ramdisk bundle flag
fitimage_assemble() {
	kernelcount=1
	dtbcount=""
	DTBS=""
	ramdiskcount=${3}
	ramdisk_image_name=${4}
	ramdisk_bundle=${5}
	setupcount=""
	bootscr_id=""
	default_dtb_image=""
	rm -f ${1} arch/${ARCH}/boot/${2}

	if [ ! -z "${UBOOT_SIGN_IMG_KEYNAME}" -a "${UBOOT_SIGN_KEYNAME}" = "${UBOOT_SIGN_IMG_KEYNAME}" ]; then
		bbfatal "Keys used to sign images and configuration nodes must be different."
	fi

	fitimage_emit_fit_header ${1}

	#
	# Step 1: Prepare a kernel image section.
	#
	fitimage_emit_section_maint ${1} imagestart

	uboot_prep_kimage

	if [ "${ramdisk_bundle}" = "1" ]; then
		initramfs_bundle_path="arch/"${UBOOT_ARCH}"/boot/"${KERNEL_IMAGETYPE_REPLACEMENT}".initramfs"
		if [ -e "${initramfs_bundle_path}" ]; then

			#
			# Include the kernel/rootfs bundle.
			#

			fitimage_emit_section_kernel ${1} "${kernelcount}" "${initramfs_bundle_path}" "${linux_comp}"
		else
			bbwarn "${initramfs_bundle_path} not found."
		fi
	else
		fitimage_emit_section_kernel ${1} "${kernelcount}" linux.bin "${linux_comp}"
	fi

	#
	# Step 2: Prepare a DTB image section
	#

	if [ -n "${KERNEL_DEVICETREE}" ]; then
		dtbcount=1
		for DTB in ${KERNEL_DEVICETREE}; do
			if echo ${DTB} | grep -q '/dts/'; then
				bbwarn "${DTB} contains the full path to the the dts file, but only the dtb name should be used."
				DTB=`basename ${DTB} | sed 's,\.dts$,.dtb,g'`
			fi

			# Skip ${DTB} if it's also provided in ${EXTERNAL_KERNEL_DEVICETREE}
			if [ -n "${EXTERNAL_KERNEL_DEVICETREE}" ] && [ -s ${EXTERNAL_KERNEL_DEVICETREE}/${DTB} ]; then
				continue
			fi

			DTB_PATH="${KERNEL_OUTPUT_DIR}/dts/$DTB"
			if [ ! -e "${DTB_PATH}" ]; then
				DTB_PATH="${KERNEL_OUTPUT_DIR}/$DTB"
			fi

			# Strip off the path component from the filename
			if "${@'false' if oe.types.boolean(d.getVar('KERNEL_DTBVENDORED')) else 'true'}"; then
				DTB=`basename $DTB`
			fi

			# Set the default dtb image if it exists in the devicetree.
			if [ ${FIT_CONF_DEFAULT_DTB} = $DTB ];then
				default_dtb_image=$(echo "$DTB" | tr '/' '_')
			fi

			DTB=$(echo "$DTB" | tr '/' '_')

			# Skip DTB if we've picked it up previously
			echo "$DTBS" | tr ' ' '\n' | grep -xq "$DTB" && continue

			DTBS="${DTBS} ${DTB}"
			DTB=$(echo $DTB | tr '/' '_')
			fitimage_emit_section_dtb ${1} ${DTB} ${DTB_PATH}
		done
	fi

	if [ -n "${EXTERNAL_KERNEL_DEVICETREE}" ]; then
		dtbcount=1
		for DTB in $(find "${EXTERNAL_KERNEL_DEVICETREE}" -name '*.dtb' -printf '%P\n' | sort) \
		$(find "${EXTERNAL_KERNEL_DEVICETREE}" -name '*.dtbo' -printf '%P\n' | sort); do
			# Set the default dtb image if it exists in the devicetree.
			if [ ${FIT_CONF_DEFAULT_DTB} = $DTB ];then
				default_dtb_image=$(echo "$DTB" | tr '/' '_')
			fi

			DTB=$(echo "$DTB" | tr '/' '_')

			# Skip DTB/DTBO if we've picked it up previously
			echo "$DTBS" | tr ' ' '\n' | grep -xq "$DTB" && continue

			DTBS="${DTBS} ${DTB}"

			# Also skip if a symlink. We'll later have each config section point at it
			[ $(symlink_points_below $DTB "${EXTERNAL_KERNEL_DEVICETREE}") ] && continue

			DTB=$(echo $DTB | tr '/' '_')
			fitimage_emit_section_dtb ${1} ${DTB} "${EXTERNAL_KERNEL_DEVICETREE}/${DTB}"
		done
	fi

	if [ -n "${FIT_CONF_DEFAULT_DTB}" ] && [ -z $default_dtb_image ]; then
		bbwarn "${FIT_CONF_DEFAULT_DTB} is not available in the list of device trees."
	fi

	#
	# Step 3: Prepare a u-boot script section
	#

	if [ -n "${UBOOT_ENV}" ] && [ -d "${STAGING_DIR_HOST}/boot" ]; then
		if [ -e "${STAGING_DIR_HOST}/boot/${UBOOT_ENV_BINARY}" ]; then
			cp ${STAGING_DIR_HOST}/boot/${UBOOT_ENV_BINARY} ${B}
			bootscr_id="${UBOOT_ENV_BINARY}"
			fitimage_emit_section_boot_script ${1} "${bootscr_id}" ${UBOOT_ENV_BINARY}
		else
			bbwarn "${STAGING_DIR_HOST}/boot/${UBOOT_ENV_BINARY} not found."
		fi
	fi

	#
	# Step 4: Prepare a setup section. (For x86)
	#
	if [ -e ${KERNEL_OUTPUT_DIR}/setup.bin ]; then
		setupcount=1
		fitimage_emit_section_setup ${1} "${setupcount}" ${KERNEL_OUTPUT_DIR}/setup.bin
	fi

	#
	# Step 5: Prepare a loadable sections.
	#
	if [ -n "${FIT_LOADABLES}" ]; then
		for LOADABLE in ${FIT_LOADABLES}; do
			if [ -e ${DEPLOY_DIR_IMAGE}/${LOADABLE} ]; then
				fitimage_emit_section_loadable ${1} "${LOADABLE}" ${DEPLOY_DIR_IMAGE}/${LOADABLE}
			fi
		done
	fi

	#
	# Step 6: Prepare a ramdisk section.
	#
	if [ "${ramdiskcount}" = "1" ] && [ "${ramdisk_bundle}" != "1" ]; then
		# Find and use the first initramfs image archive type we find
		for img in cpio.lz4 cpio.lzo cpio.lzma cpio.xz cpio.zst cpio.gz ext2.gz cpio; do
			initramfs_path="${DEPLOY_DIR_IMAGE}/${ramdisk_image_name}.${img}"
			echo "Using $initramfs_path"
			if [ -e "${initramfs_path}" ]; then
				fitimage_emit_section_ramdisk ${1} "${ramdiskcount}" "${ramdisk_image_name}" "${initramfs_path}"
				break
			fi
		done
	fi

	fitimage_emit_section_maint ${1} sectend

	# Force the first Kernel and DTB in the default config
	kernelcount=1
	if [ -n "${dtbcount}" ]; then
		dtbcount=1
	fi

	#
	# Step 7: Prepare a configurations section
	#
	fitimage_emit_section_maint ${1} confstart

	# kernel-fitimage.bbclass currently only supports a single kernel (no less or
	# more) to be added to the FIT image along with 0 or more device trees and
	# 0 or 1 ramdisk.
	# It is also possible to include an initramfs bundle (kernel and rootfs in one binary)
	# When the initramfs bundle is used ramdisk is disabled.
	# If a device tree is to be part of the FIT image, then select
	# the default configuration to be used is based on the dtbcount. If there is
	# no dtb present than select the default configuation to be based on
	# the kernelcount.
	if [ -n "${DTBS}" ]; then
		dtb_idx=1
		for DTB in ${DTBS}; do
			dtb_ext=${DTB##*.}
			if [ "${dtb_ext}" = "dtbo" ]; then
				fitimage_emit_section_config ${1} "" "${DTB}" "" "" "" "" "" "`expr ${dtb_idx} = ${dtbcount}`" "${default_dtb_image}"
			else
				fitimage_emit_section_config ${1} "${kernelcount}" "${DTB}" "${ramdiskcount}" "${bootscr_id}" "${setupcount}" "${FIT_LOADABLES}" "`expr ${dtb_idx} = ${dtbcount}`" "${default_dtb_image}"
			fi
			dtb_idx=`expr ${dtb_idx} + 1`
		done
        unset dtb_idx
	else
		defaultconfigcount=1
		fitimage_emit_section_config ${1} "${kernelcount}" "" "${ramdiskcount}" "${bootscr_id}" "${setupcount}" "${FIT_LOADABLES}" "${defaultconfigcount}" "${default_dtb_image}"
	fi

	fitimage_emit_section_maint ${1} sectend

	fitimage_emit_section_maint ${1} fitend

	#
	# Step 8: Assemble the image
	#
	${UBOOT_MKIMAGE} \
		${@'-D "${UBOOT_MKIMAGE_DTCOPTS}"' if len('${UBOOT_MKIMAGE_DTCOPTS}') else ''} \
		-f ${1} \
		${KERNEL_OUTPUT_DIR}/${2}

	#
	# Step 9: Sign the image
	#
	if [ "${UBOOT_SIGN_ENABLE}" = "1" ] ; then
		${UBOOT_MKIMAGE_SIGN} \
			${@'-D "${UBOOT_MKIMAGE_DTCOPTS}"' if len('${UBOOT_MKIMAGE_DTCOPTS}') else ''} \
			-F -k "${UBOOT_SIGN_KEYDIR}" \
			-r ${KERNEL_OUTPUT_DIR}/${2} \
			${UBOOT_MKIMAGE_SIGN_ARGS}
	fi
}

do_assemble_fitimage_initramfs() {
	if echo ${KERNEL_IMAGETYPES} | grep -wq "fitImage" ; then
		cd ${B}
		if test -n "${INITRAMFS_IMAGE}" ; then
			if [ "${INITRAMFS_IMAGE_BUNDLE}" = "1" ]; then
				fitimage_assemble fit-image-${INITRAMFS_IMAGE}.its fitImage-bundle "" "" ${INITRAMFS_IMAGE_BUNDLE}
				ln -sf fitImage-bundle ${B}/${KERNEL_OUTPUT_DIR}/fitImage
			else
				fitimage_assemble fit-image-${INITRAMFS_IMAGE}.its fitImage-${INITRAMFS_IMAGE} 1 ${INITRAMFS_IMAGE_NAME} 0
			fi
		fi

		if test -n "${INITRAMFS_RECOVERY_IMAGE}" ; then
			fitimage_assemble fit-image-${INITRAMFS_RECOVERY_IMAGE}.its fitImage-${INITRAMFS_RECOVERY_IMAGE} 1 ${INITRAMFS_RECOVERY_IMAGE_NAME} 0
		fi
        fi
}

kernel_do_deploy:append() {
	if echo ${KERNEL_IMAGETYPES} | grep -wq "fitImage"; then
		if [ -n "${INITRAMFS_RECOVERY_IMAGE}" ]; then
			bbnote "Copying fit-image-${INITRAMFS_RECOVERY_IMAGE}.its source file..."
			install -m 0644 ${B}/fit-image-${INITRAMFS_RECOVERY_IMAGE}.its "$deployDir/fitImage-its-${INITRAMFS_RECOVERY_IMAGE_NAME}-${KERNEL_FIT_NAME}.its"
			if [ -n "${KERNEL_FIT_LINK_NAME}" ] ; then
				ln -snf fitImage-its-${INITRAMFS_RECOVERY_IMAGE_NAME}-${KERNEL_FIT_NAME}.its "$deployDir/fitImage-its-${INITRAMFS_RECOVERY_IMAGE_NAME}-${KERNEL_FIT_LINK_NAME}"
			fi

			bbnote "Copying fitImage-${INITRAMFS_RECOVERY_IMAGE} file..."
			install -m 0644 ${B}/${KERNEL_OUTPUT_DIR}/fitImage-${INITRAMFS_RECOVERY_IMAGE} "$deployDir/fitImage-${INITRAMFS_RECOVERY_IMAGE_NAME}-${KERNEL_FIT_NAME}${KERNEL_FIT_BIN_EXT}"
			if [ -n "${KERNEL_FIT_LINK_NAME}" ] ; then
				ln -snf fitImage-${INITRAMFS_RECOVERY_IMAGE_NAME}-${KERNEL_FIT_NAME}${KERNEL_FIT_BIN_EXT} "$deployDir/fitImage-${INITRAMFS_RECOVERY_IMAGE_NAME}-${KERNEL_FIT_LINK_NAME}"
			fi
		fi
	fi
}
