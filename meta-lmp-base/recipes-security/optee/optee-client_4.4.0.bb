require optee-client-fio.inc

SRCREV = "d221676a58b305bddbf97db00395205b3038de8e"

SRC_URI += " \
	file://0001-FIO-extras-pkcs11-change-UUID-to-avoid-conflict-with.patch \
"

EXTRA_OECMAKE += "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
