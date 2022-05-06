# Docker packages
CORE_IMAGE_BASE_INSTALL += " \
    docker \
    docker-credential-helper-fio \
    docker-compose \
"

EXTRA_USERS_PARAMS += "\
usermod -a -G docker ${LMP_USER}; \
"
