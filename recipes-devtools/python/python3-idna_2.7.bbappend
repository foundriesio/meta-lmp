# Remove bundled egg-info
do_compile_prepend() {
    rm -rf ${S}/idna.egg-info
}
