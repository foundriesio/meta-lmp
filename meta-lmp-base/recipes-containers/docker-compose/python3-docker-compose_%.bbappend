inherit update-alternatives

# Define alternative to allow compose switch to take over
ALTERNATIVE:${PN} = "docker-compose"
ALTERNATIVE_PRIORITY = "30"
ALTERNATIVE_LINK_NAME[docker-compose] = "${base_bindir}/docker-compose"
