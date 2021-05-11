# Linux microPlatform extensions to the upstream OE-core kernel-fitimage class

inherit kernel-fitimage

# Default value for deployment filenames
FPGA_BINARY ?= "fpga.bin"
FIT_LOADABLES ?= ""

# Allow transition to cover CVE-2021-27097 and CVE-2021-27138
FIT_NODE_SEPARATOR ?= "-"

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
	kernel_sign_keyname="${UBOOT_SIGN_KEYNAME}"

	ENTRYPOINT="${UBOOT_ENTRYPOINT}"
	if [ -n "${UBOOT_ENTRYSYMBOL}" ]; then
		ENTRYPOINT=`${HOST_PREFIX}nm vmlinux | \
			awk '$3=="${UBOOT_ENTRYSYMBOL}" {print "0x"$1;exit}'`
	fi

	cat << EOF >> ${1}
                kernel${FIT_NODE_SEPARATOR}${2} {
                        description = "Linux kernel";
                        data = /incbin/("${3}");
                        type = "kernel";
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
	dtb_sign_keyname="${UBOOT_SIGN_KEYNAME}"

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
                fdt${FIT_NODE_SEPARATOR}${2} {
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

# Emit the fitImage ITS u-boot script section
#
# $1 ... .its filename
# $2 ... Image counter
# $3 ... Path to boot script image
fitimage_emit_section_boot_script() {

	bootscr_csum="${FIT_HASH_ALG}"
	bootscr_sign_algo="${FIT_SIGN_ALG}"
	bootscr_sign_keyname="${UBOOT_SIGN_KEYNAME}"

	cat << EOF >> ${1}
                bootscr${FIT_NODE_SEPARATOR}${2} {
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
                setup${FIT_NODE_SEPARATOR}${2} {
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
# $3 ... Path to ramdisk image
fitimage_emit_section_ramdisk() {

	ramdisk_csum="${FIT_HASH_ALG}"
	ramdisk_sign_algo="${FIT_SIGN_ALG}"
	ramdisk_sign_keyname="${UBOOT_SIGN_KEYNAME}"
	ramdisk_loadline=""
	ramdisk_entryline=""

	if [ -n "${UBOOT_RD_LOADADDRESS}" ]; then
		ramdisk_loadline="load = <${UBOOT_RD_LOADADDRESS}>;"
	fi
	if [ -n "${UBOOT_RD_ENTRYPOINT}" ]; then
		ramdisk_entryline="entry = <${UBOOT_RD_ENTRYPOINT}>;"
	fi

	cat << EOF >> ${1}
                ramdisk${FIT_NODE_SEPARATOR}${2} {
                        description = "${INITRAMFS_IMAGE}";
                        data = /incbin/("${3}");
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
# $7 ... fpga ID (LmP specific)
# $8 ... loadable ID (LmP specific)
# $9 ... default flag
fitimage_emit_section_config() {

	conf_csum="${FIT_HASH_ALG}"
	conf_sign_algo="${FIT_SIGN_ALG}"
	if [ -n "${UBOOT_SIGN_ENABLE}" ] ; then
		conf_sign_keyname="${UBOOT_SIGN_KEYNAME}"
	fi

	its_file="${1}"
	kernel_id="${2}"
	dtb_image="${3}"
	ramdisk_id="${4}"
	bootscr_id="${5}"
	config_id="${6}"
	fpga_id="${7}"
	loadable_id="${8}"
	default_flag="${9}"

	# Test if we have any DTBs at all
	sep=""
	conf_desc=""
	conf_node="conf${FIT_NODE_SEPARATOR}"
	kernel_line=""
	fdt_line=""
	ramdisk_line=""
	bootscr_line=""
	setup_line=""
	fpga_line=""
	loadable_line=""
	default_line=""

	# conf node name is selected based on dtb ID if it is present,
	# otherwise no index is used (differs from kernel-fitimage, which
	# uses kernel ID, but then breaks current qemu boot.cmds)
	if [ -n "${dtb_image}" ]; then
		conf_node=$conf_node${dtb_image}
	fi

	if [ -n "${kernel_id}" ]; then
		conf_desc="Linux kernel"
		sep=", "
		kernel_line="kernel = \"kernel${FIT_NODE_SEPARATOR}${kernel_id}\";"
	fi

	if [ -n "${dtb_image}" ]; then
		conf_desc="${conf_desc}${sep}FDT blob"
		sep=", "
		fdt_line="fdt = \"fdt${FIT_NODE_SEPARATOR}${dtb_image}\";"
	fi

	if [ -n "${ramdisk_id}" ]; then
		conf_desc="${conf_desc}${sep}ramdisk"
		sep=", "
		ramdisk_line="ramdisk = \"ramdisk${FIT_NODE_SEPARATOR}${ramdisk_id}\";"
	fi

	if [ -n "${bootscr_id}" ]; then
		conf_desc="${conf_desc}${sep}u-boot script"
		sep=", "
		bootscr_line="bootscr = \"bootscr${FIT_NODE_SEPARATOR}${bootscr_id}\";"
	fi

	if [ -n "${config_id}" ]; then
		conf_desc="${conf_desc}${sep}setup"
		sep=", "
		setup_line="setup = \"setup${FIT_NODE_SEPARATOR}${config_id}\";"
	fi

	if [ -n "${fpga_id}" ]; then
		conf_desc="${conf_desc}${sep}fpga"
		sep=", "
		fpga_line="fpga = \"fpga${FIT_NODE_SEPARATOR}${fpga_id}\";"
	fi

	if [ -n "${loadable_id}" ]; then
		i=0
		for LOADABLE in ${loadable_id}; do
			if [ -e ${DEPLOY_DIR_IMAGE}/${LOADABLE} ]; then
				i=`expr ${i} + 1`
				if [ -z "${loadable_line}" ]; then
					conf_desc="${conf_desc}${sep}loadables"
				fi
				loadable_line="${loadable_line}loadable_${i} = \"loadable${FIT_NODE_SEPARATOR}${LOADABLE}\"; "
			fi
		done
	fi

	if [ "${default_flag}" = "1" ]; then
		# default node is selected based on dtb ID if it is present
		if [ -n "${dtb_image}" ]; then
			default_line="default = \"conf${FIT_NODE_SEPARATOR}${dtb_image}\";"
		else
			default_line="default = \"conf${FIT_NODE_SEPARATOR}\";"
		fi
	fi

	cat << EOF >> ${its_file}
                ${default_line}
                $conf_node {
                        description = "${default_flag} ${conf_desc}";
                        ${kernel_line}
                        ${fdt_line}
                        ${ramdisk_line}
                        ${bootscr_line}
                        ${setup_line}
                        ${fpga_line}
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

		if [ -n "${fpga_id}" ]; then
			sign_line="${sign_line}${sep}\"fpga\""
		fi

		if [ -n "${loadable_id}" ]; then
			i=0
			for LOADABLE in ${loadable_id}; do
				if [ -e ${DEPLOY_DIR_IMAGE}/${LOADABLE} ]; then
					i=`expr ${i} + 1`
					sign_line="${sign_line}${sep}\"loadable_${i}\""
				fi
			done
		fi

		sign_line="${sign_line};"

		cat << EOF >> ${its_file}
                        signature-1 {
                                algo = "${conf_csum},${conf_sign_algo}";
                                key-name-hint = "${conf_sign_keyname}";
                                ${sign_line}
                        };
EOF
	fi

	cat << EOF >> ${its_file}
                };
EOF
}

#
# Emit the fitImage ITS fpga section
#
# $1 ... .its filename
# $2 ... Image counter
# $3 ... Path to fpga image
fitimage_emit_section_fpga() {

	fpga_csum="${FIT_HASH_ALG}"
	fpga_loadline=""

	if [ -n "${FPGA_LOADADDRESS}" ]; then
		fpga_loadline="load = <${FPGA_LOADADDRESS}>;"
	fi

	cat << EOF >> ${1}
                fpga${FIT_NODE_SEPARATOR}${2} {
                        description = "FPGA binary";
                        data = /incbin/("${3}");
                        type = "fpga";
                        arch = "${UBOOT_ARCH}";
                        compression = "none";
                        ${fpga_loadline}
                        hash-1 {
                                algo = "${fpga_csum}";
                        };
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
                loadable${FIT_NODE_SEPARATOR}${2} {
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
fitimage_assemble() {
	kernelcount=1
	dtbcount=""
	DTBS=""
	ramdiskcount=${3}
	setupcount=""
	bootscr_id=""
	fpgacount=""
	rm -f ${1} arch/${ARCH}/boot/${2}

	fitimage_emit_fit_header ${1}

	#
	# Step 1: Prepare a kernel image section.
	#
	fitimage_emit_section_maint ${1} imagestart

	uboot_prep_kimage

	if [ "${INITRAMFS_IMAGE_BUNDLE}" = "1" ]; then
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

			DTB_PATH="arch/${ARCH}/boot/dts/${DTB}"
			if [ ! -e "${DTB_PATH}" ]; then
				DTB_PATH="arch/${ARCH}/boot/${DTB}"
			fi

			DTB=$(echo "${DTB}" | tr '/' '_')
			DTBS="${DTBS} ${DTB}"
			fitimage_emit_section_dtb ${1} ${DTB} ${DTB_PATH}
		done
	fi

	if [ -n "${EXTERNAL_KERNEL_DEVICETREE}" ]; then
		dtbcount=1
		for DTB in $(find "${EXTERNAL_KERNEL_DEVICETREE}" \( -name '*.dtb' -o -name '*.dtbo' \) -printf '%P\n' | sort); do
			DTB=$(echo "${DTB}" | tr '/' '_')
			DTBS="${DTBS} ${DTB}"
			fitimage_emit_section_dtb ${1} ${DTB} "${EXTERNAL_KERNEL_DEVICETREE}/${DTB}"
		done
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
	if [ -e arch/${ARCH}/boot/setup.bin ]; then
		setupcount=1
		fitimage_emit_section_setup ${1} "${setupcount}" arch/${ARCH}/boot/setup.bin
	fi

	#
	# Step 5: Prepare a fpga section.
	#
	if [ -e ${DEPLOY_DIR_IMAGE}/${FPGA_BINARY} ]; then
		fpgacount=1
		fitimage_emit_section_fpga ${1} "${fpgacount}" ${DEPLOY_DIR_IMAGE}/${FPGA_BINARY}
	fi

	#
	# Step 5a: Prepare a loadable sections.
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
	if [ "x${ramdiskcount}" = "x1" ] && [ "${INITRAMFS_IMAGE_BUNDLE}" != "1" ]; then
		# Find and use the first initramfs image archive type we find
		for img in cpio.lz4 cpio.lzo cpio.lzma cpio.xz cpio.gz ext2.gz cpio; do
			initramfs_path="${DEPLOY_DIR_IMAGE}/${INITRAMFS_IMAGE_NAME}.${img}"
			echo "Using $initramfs_path"
			if [ -e "${initramfs_path}" ]; then
				fitimage_emit_section_ramdisk ${1} "${ramdiskcount}" "${initramfs_path}"
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
		i=1
		for DTB in ${DTBS}; do
			dtb_ext=${DTB##*.}
			if [ "${dtb_ext}" = "dtbo" ]; then
				fitimage_emit_section_config ${1} "" "${DTB}" "" "" "" "" "" "`expr ${i} = ${dtbcount}`"
			else
				fitimage_emit_section_config ${1} "${kernelcount}" "${DTB}" "${ramdiskcount}" "${bootscr_id}" "${setupcount}" "${fpgacount}" "${FIT_LOADABLES}" "`expr ${i} = ${dtbcount}`"
			fi
			i=`expr ${i} + 1`
		done
	else
		defaultconfigcount=1
		fitimage_emit_section_config ${1} "${kernelcount}" "" "${ramdiskcount}" "${bootscr_id}" "${setupcount}" "${fpgacount}" "${FIT_LOADABLES}" "${defaultconfigcount}"
	fi

	fitimage_emit_section_maint ${1} sectend

	fitimage_emit_section_maint ${1} fitend

	#
	# Step 8: Assemble the image
	#
	${UBOOT_MKIMAGE} \
		${@'-D "${UBOOT_MKIMAGE_DTCOPTS}"' if len('${UBOOT_MKIMAGE_DTCOPTS}') else ''} \
		-f ${1} \
		arch/${ARCH}/boot/${2}

	#
	# Step 9: Sign the image and add public key to U-Boot dtb
	#
	if [ "x${UBOOT_SIGN_ENABLE}" = "x1" ] ; then
		add_key_to_u_boot=""
		if [ -n "${UBOOT_DTB_BINARY}" ]; then
			# The u-boot.dtb is a symlink to UBOOT_DTB_IMAGE, so we need copy
			# both of them, and don't dereference the symlink.
			cp -P ${STAGING_DATADIR}/u-boot*.dtb ${B}
			add_key_to_u_boot="-K ${B}/${UBOOT_DTB_BINARY}"
		fi
		${UBOOT_MKIMAGE_SIGN} \
			${@'-D "${UBOOT_MKIMAGE_DTCOPTS}"' if len('${UBOOT_MKIMAGE_DTCOPTS}') else ''} \
			-F -k "${UBOOT_SIGN_KEYDIR}" \
			$add_key_to_u_boot \
			-r arch/${ARCH}/boot/${2} \
			${UBOOT_MKIMAGE_SIGN_ARGS}
	fi
}
