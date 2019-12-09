# Remove syslog as it is not required with systemd
SRC_URI_remove = "file://syslog.cfg"

busybox_cfg_variable() {
    CONF_SED_SCRIPT="$CONF_SED_SCRIPT /^CONFIG_$1[ =]/d;"
    if test "$2" = "n"; then
        echo "# CONFIG_$1 is not set" >> ${S}/.config
    else
        echo "CONFIG_$1=$2" >> ${S}/.config
    fi
}

do_prepare_config_append() {
    CONF_SED_SCRIPT=""

    # No need for klogd as that is provided by systemd
    busybox_cfg_variable KLOGD n

    sed -i -e "${CONF_SED_SCRIPT}" ${S}/.config
}
