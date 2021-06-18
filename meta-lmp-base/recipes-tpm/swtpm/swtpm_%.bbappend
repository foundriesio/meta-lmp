# BUG STATEMENT:
# Upstream recipe is breaking due to a parsing error when static IDs are enabled:
# ERROR: build/conf/../../layers/meta-security/meta-tpm/recipes-tpm/swtpm/swtpm_0.2.0.bb: argument -d/--home-dir: expected one argument
# ERROR: build/conf/../../layers/meta-security/meta-tpm/recipes-tpm/swtpm/swtpm_0.2.0.bb: swtpm: Unable to parse arguments for USERADD_PARAM_swtpm '--system -g tss --home-dir      --no-create-home  --shell /bin/false swtpm':
# ERROR: Failed to parse recipe: build/conf/../../layers/meta-security/meta-tpm/recipes-tpm/swtpm/swtpm_0.2.0.bb
#
# FIX:
# Drop --home-dir
#
# TODO: Submit upstream
USERADD_PARAM_${PN} = "--system -g ${TSS_GROUP} \
    --no-create-home --shell /bin/false ${BPN}"
