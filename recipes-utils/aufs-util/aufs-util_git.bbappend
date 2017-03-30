# Temporary build-failure fix from a pending upstream patch

do_compile_class-native () {
	oe_runmake tools CPPFLAGS="-I${S}/include -I${S}/libau" CC="${BUILD_CC}"
}
