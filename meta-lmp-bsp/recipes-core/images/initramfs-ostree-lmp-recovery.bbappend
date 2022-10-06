FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PACKAGE_INSTALL:append = " initramfs-module-debug \
		       	   lmp-recovery-module-sample-uboot-env \
		       	   lmp-recovery-module-sample-udhcpc \
			   lmp-recovery-module-sample-image-download"
