#!/bin/sh
################################################################
#
# This is a simple docker used to show hanling of
# aktualizr-lite callbacks
#
################################################################

#
# directory paths for setup and notifying
#
CBFILE=${CALLBACK_SCRIPT:-"/var/sota/example-callback.sh"}
TOML=${TOML_FILE:-"/etc/sota/conf.d/z-90-handle-callback.toml"}
UPDATES=${UPDATE_DIR:-"/var/lib/example-callbacks"}

#
# timing values
# DELAY is the time in seconds between checking for notifications
#
DELAY=1

#
# Logging function: reports date/time to docker log
#
function log()
{
	echo "$(date +"%b %e %T") handle-callback: $*"
}

#
# Setup function for activating the callback mechanism
# with aktualizr-lite
#
function setup()
{
        #
        # Make sure callback file has not changed, otherwise change it
        #
	old="$(md5sum ${CBFILE} 2> /dev/null | cut -d ' ' -f 1)"
	new="$(md5sum $(basename ${CBFILE}) | cut -d ' ' -f 1)"
	if [[ ! -e $CBFILE ]] || [[ "$old" != "$new" ]]
	then
		cp `basename ${CBFILE}` ${CBFILE}
		chmod 755 ${CBFILE}
		echo -e "[pacman]\ncallback_program = ${CBFILE}" > ${TOML}
	fi
}

###################################################################
#
# Start of process
#
###################################################################

log "Starting handling of aktualizr-lite callbacks Container"
setup

#
# continue forever
#
while :
do
	for update in $(ls $UPDATES/* 2> /dev/null)
	do
		IFS=, read msg trgt result < $update
		rm $update
                #
                # Current messages are:
                # - check-for-update-pre  return: none
                # - check-for-update-post return: none
                # - download-pre          return: none
                # - download-post         return: OK or FAILED
                # - install-pre           return: none
                # - install-post          return: NEEDS_COMPLETION, OK, or FAILED

		case $msg in
		check-for-update-pre)
			log "check-for-update-pre"
			;;
		check-for-update-post)
			log "check-for-update-pre"
			;;
		download-pre)
			log "download-pre"
			;;
		download-post)
			if [ "$result" = "OK" ]
			then
				log "download-post:" "OK"
			else
				log "download-post:" "$result"
			fi
			;;
		install-pre)
			log "install-pre"
			;;
		install-post)
			log "install-post:" "$result"
			;;
		*)
			;;
		esac
	done
	sleep ${DELAY}
done
