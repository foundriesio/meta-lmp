# Builds for ARM will result in an empty grub package, so allow it to be
# created in order to satisfy common package dependencies (installer).
ALLOW_EMPTY_${PN} = "1"
