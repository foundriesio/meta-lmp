FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Based on the original recipe but changed for LmP (done to avoid changing via removal)
## NOTE: This list will have to be reviewed / updated on every systemd recipe update from OE-Core
PACKAGECONFIG ?= " \
    ${@bb.utils.filter('DISTRO_FEATURES', 'acl audit efi ldconfig pam selinux smack usrmerge polkit seccomp', d)} \
    ${@bb.utils.filter('MACHINE_FEATURES', 'tpm2', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'wifi', 'rfkill', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'xkbcommon', '', d)} \
    backlight \
    binfmt \
    cgroupv2 \
    cryptsetup \
    cryptsetup-plugins \
    gshadow \
    hibernate \
    hostnamed \
    idn \
    ima \
    journal-upload \
    kmod \
    localed \
    logind \
    machined \
    myhostname \
    nss \
    nss-mymachines \
    nss-resolve \
    openssl \
    quotacheck \
    p11kit \
    randomseed \
    resolved \
    serial-getty-generator \
    set-time-epoch \
    sysusers \
    sysvinit \
    timedated \
    timesyncd \
    userdb \
    utmp \
    vconsole \
    wheel-group \
    xz \
    zstd \
"

ALTERNATIVE_PRIORITY[resolv-conf] = "300"

DEF_FALLBACK_NTP_SERVERS ?= "time1.google.com time2.google.com time3.google.com time.cloudflare.com pool.ntp.org"
EXTRA_OEMESON += ' \
	-Dntp-servers="${DEF_FALLBACK_NTP_SERVERS}" \
'

SRC_URI:append = " \
	file://0001-tmpfiles-tmp.conf-reduce-cleanup-age-to-half.patch \
	file://systemd-networkd-wait-online.service.in-use-any-by-d.patch \
	file://systemd-timesyncd-update.service \
"

# Depend on systemd-boot as the efi payload is provided by a different recipe
RDEPENDS:${PN} += "${@bb.utils.contains('EFI_PROVIDER', 'systemd-boot', 'systemd-boot', '', d)}"

# /var in lmp is expected to be rw, so drop volatile-binds service files
RDEPENDS:${PN}:remove = "volatile-binds"

do_install:append() {
	# drop /run/lock as it is already provided via legacy.conf
	sed -i '/\/run\/lock/d' ${D}${nonarch_libdir}/tmpfiles.d/00-create-volatile.conf
	if [ ${@ oe.types.boolean('${VOLATILE_LOG_DIR}') } = True ]; then
		sed -i '/^d \/var\/log /d' ${D}${nonarch_libdir}/tmpfiles.d/var.conf
		echo 'L+ /var/log - - - - /var/volatile/log' >> ${D}${nonarch_libdir}/tmpfiles.d/00-create-volatile.conf
	else
		# Make sure /var/log is not a link to volatile (e.g. after system updates)
		sed -i '/\[Service\]/aExecStartPre=-/bin/rm -f /var/log' ${D}${systemd_system_unitdir}/systemd-journal-flush.service
		(cd ${D}${localstatedir}; rmdir -v --parents log/journal)
	fi

	# Workaround for https://github.com/systemd/systemd/issues/11329
	install -m 0644 ${WORKDIR}/systemd-timesyncd-update.service ${D}${systemd_system_unitdir}
	ln -sf ../systemd-timesyncd-update.service ${D}${systemd_system_unitdir}/sysinit.target.wants/systemd-timesyncd-update.service

	# Remove systemd-boot as it is provided by a separated recipe and we can't disable via pkgconfig
	if ${@bb.utils.contains('PACKAGECONFIG', 'efi', 'true', 'false', d)}; then
		rm -r ${D}${nonarch_libdir}/systemd/boot
	fi

	(cd ${D}${localstatedir}; rmdir -v --parents lib/systemd)
}
