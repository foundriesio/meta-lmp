do_deploy_append_raspberrypi3-64() {
    # Don't hardcode the default device tree file
    sed -i -e "s/^device_tree=/#device_tree=/g" ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
}
