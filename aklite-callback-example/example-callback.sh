#!/bin/sh

DEST=/var/lib/example-callbacks
APP_NAME="$(dirname $0)/compose-apps/aklite-callback-example"
TOML="/etc/sota/conf.d/z-90-handle-callback-example.toml"

# First make sure this app is still installed:
# aktualizr-lite "uninstalls" a compose-app by basically running:
#  docker-compose stop; rm -rf /var/sota/compose-apps/<APP_NAME>
# we can detect we were deleted by looking for that directory:
if [ ! -d "${APP_NAME}" ] ; then
       if [ -f "${TOML}" ] ; then
               echo "Container appears to be removed. disabling callback"
               rm "${TOML}"
       fi

       # this gets tricky: we need to restart aklite. We don't want to do
       # it when aklite is performing an update. To be safe we just exit
       # now and eventually aklite will restart and stop calling us.
       exit 0
fi

data="${MESSAGE},${INSTALL_TARGET}"
if [ -n "${RESULT}" ]
then
	data="${data},${RESULT}"
fi

echo "${data}" > $DEST/callback_$(date +%s.%N)
