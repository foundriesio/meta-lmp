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
}

#
# Emit the fitImage ITS DTB section
#
# $1 ... .its filename
# $2 ... Image counter
# $3 ... Path to DTB image
fitimage_emit_section_dtb() {

	dtb_csum="${FIT_HASH_ALG}"

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
}

#
# Emit the fitImage ITS configuration section
#
# $1 ... .its filename
# $2 ... Linux kernel ID
# $3 ... DTB image name
# $4 ... ramdisk ID
# $5 ... setup ID
# $6 ... fpga ID
# $7 ... loadable ID
# $8 ... default flag
fitimage_emit_section_config() {

	conf_csum="${FIT_HASH_ALG}"
	conf_sign_algo="${FIT_SIGN_ALG}"
	if [ -n "${UBOOT_SIGN_ENABLE}" ] ; then
		conf_sign_keyname="${UBOOT_SIGN_KEYNAME}"
	fi

	# Test if we have any DTBs at all
	sep=""
	conf_desc=""
	kernel_line=""
	fdt_line=""
	ramdisk_line=""
	setup_line=""
	fpga_line=""
	loadable_line=""
	default_line=""

	if [ -n "${2}" ]; then
		conf_desc="Linux kernel"
		sep=", "
		kernel_line="kernel = \"kernel${FIT_NODE_SEPARATOR}${2}\";"
	fi

	if [ -n "${3}" ]; then
		conf_desc="${conf_desc}${sep}FDT blob"
		sep=", "
		fdt_line="fdt = \"fdt${FIT_NODE_SEPARATOR}${3}\";"
	fi

	if [ -n "${4}" ]; then
		conf_desc="${conf_desc}${sep}ramdisk"
		sep=", "
		ramdisk_line="ramdisk = \"ramdisk${FIT_NODE_SEPARATOR}${4}\";"
	fi

	if [ -n "${5}" ]; then
		conf_desc="${conf_desc}${sep}setup"
		setup_line="setup = \"setup${FIT_NODE_SEPARATOR}${5}\";"
	fi

	if [ -n "${6}" ]; then
		conf_desc="${conf_desc}${sep}fpga"
		fpga_line="fpga = \"fpga${FIT_NODE_SEPARATOR}${6}\";"
	fi

	if [ -n "${7}" ]; then
		i=0
		for LOADABLE in ${7}; do
			if [ -e ${DEPLOY_DIR_IMAGE}/${LOADABLE} ]; then
				i=`expr ${i} + 1`
				if [ -n "${loadable_line}" ]; then
					conf_desc="${conf_desc}${sep}loadables"
				fi
				loadable_line="${loadable_line}loadable_${i} = \"loadable${FIT_NODE_SEPARATOR}${LOADABLE}\"; "
			fi
		done
	fi

	if [ "${8}" = "1" ]; then
		default_line="default = \"conf${FIT_NODE_SEPARATOR}${3}\";"
	fi

	cat << EOF >> ${1}
                ${default_line}
                conf${FIT_NODE_SEPARATOR}${3} {
                        description = "${8} ${conf_desc}";
                        ${kernel_line}
                        ${fdt_line}
                        ${ramdisk_line}
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

		if [ -n "${2}" ]; then
			sign_line="${sign_line}${sep}\"kernel\""
			sep=", "
		fi

		if [ -n "${3}" ]; then
			sign_line="${sign_line}${sep}\"fdt\""
			sep=", "
		fi

		if [ -n "${4}" ]; then
			sign_line="${sign_line}${sep}\"ramdisk\""
			sep=", "
		fi

		if [ -n "${5}" ]; then
			sign_line="${sign_line}${sep}\"setup\""
			sep=", "
		fi

		if [ -n "${6}" ]; then
			sign_line="${sign_line}${sep}\"fpga\""
		fi

		if [ -n "${7}" ]; then
			i=0
			for LOADABLE in ${7}; do
				if [ -e ${DEPLOY_DIR_IMAGE}/${LOADABLE} ]; then
					i=`expr ${i} + 1`
					sign_line="${sign_line}${sep}\"loadable_${i}\""
				fi
			done
		fi

		sign_line="${sign_line};"

		cat << EOF >> ${1}
                        signature-1 {
                                algo = "${conf_csum},${conf_sign_algo}";
                                key-name-hint = "${conf_sign_keyname}";
                                ${sign_line}
                        };
EOF
	fi

	cat << EOF >> ${1}
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
	fpgacount=""
	rm -f ${1} arch/${ARCH}/boot/${2}

	fitimage_emit_fit_header ${1}

	#
	# Step 1: Prepare a kernel image section.
	#
	fitimage_emit_section_maint ${1} imagestart

	uboot_prep_kimage
	fitimage_emit_section_kernel ${1} "${kernelcount}" linux.bin "${linux_comp}"

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
	# Step 3: Prepare a setup section. (For x86)
	#
	if [ -e arch/${ARCH}/boot/setup.bin ]; then
		setupcount=1
		fitimage_emit_section_setup ${1} "${setupcount}" arch/${ARCH}/boot/setup.bin
	fi

	#
	# Step 4: Prepare a fpga section.
	#
	if [ -e ${DEPLOY_DIR_IMAGE}/${FPGA_BINARY} ]; then
		fpgacount=1
		fitimage_emit_section_fpga ${1} "${fpgacount}" ${DEPLOY_DIR_IMAGE}/${FPGA_BINARY}
	fi

	#
	# Step 4a: Prepare a loadable sections.
	#
	if [ -n "${FIT_LOADABLES}" ]; then
		for LOADABLE in ${FIT_LOADABLES}; do
			if [ -e ${DEPLOY_DIR_IMAGE}/${LOADABLE} ]; then
				fitimage_emit_section_loadable ${1} "${LOADABLE}" ${DEPLOY_DIR_IMAGE}/${LOADABLE}
			fi
		done
	fi

	#
	# Step 5: Prepare a ramdisk section.
	#
	if [ "x${ramdiskcount}" = "x1" ] ; then
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
	# Step 6: Prepare a configurations section
	#
	fitimage_emit_section_maint ${1} confstart

	if [ -n "${DTBS}" ]; then
		n=1
		for DTB in ${DTBS}; do
			dtb_ext=${DTB##*.}
			if [ "${dtb_ext}" = "dtbo" ]; then
				fitimage_emit_section_config ${1} "" "${DTB}" "" "" "" "${FIT_LOADABLES}" "`expr ${n} = ${dtbcount}`"
			else
				fitimage_emit_section_config ${1} "${kernelcount}" "${DTB}" "${ramdiskcount}" "${setupcount}" "${fpgacount}" "${FIT_LOADABLES}" "`expr ${n} = ${dtbcount}`"
			fi
			n=`expr ${n} + 1`
		done
	else
		fitimage_emit_section_config ${1} "${kernelcount}" "" "${ramdiskcount}" "${setupcount}" "${fpgacount}" "${FIT_LOADABLES}" ""
	fi

	fitimage_emit_section_maint ${1} sectend

	fitimage_emit_section_maint ${1} fitend

	#
	# Step 7: Assemble the image
	#
	uboot-mkimage \
		${@'-D "${UBOOT_MKIMAGE_DTCOPTS}"' if len('${UBOOT_MKIMAGE_DTCOPTS}') else ''} \
		-f ${1} \
		arch/${ARCH}/boot/${2}

	#
	# Step 8: Sign the image and add public key to U-Boot dtb
	#
	if [ "x${UBOOT_SIGN_ENABLE}" = "x1" ] ; then
		add_key_to_u_boot=""
		if [ -n "${UBOOT_DTB_BINARY}" ]; then
			# The u-boot.dtb is a symlink to UBOOT_DTB_IMAGE, so we need copy
			# both of them, and don't dereference the symlink.
			cp -P ${STAGING_DATADIR}/u-boot*.dtb ${B}
			add_key_to_u_boot="-K ${B}/${UBOOT_DTB_BINARY}"
		fi
		uboot-mkimage \
			${@'-D "${UBOOT_MKIMAGE_DTCOPTS}"' if len('${UBOOT_MKIMAGE_DTCOPTS}') else ''} \
			-F -k "${UBOOT_SIGN_KEYDIR}" \
			$add_key_to_u_boot \
			-r arch/${ARCH}/boot/${2}
	fi
}
