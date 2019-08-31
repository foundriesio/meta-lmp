# Docker packages
CORE_IMAGE_BASE_INSTALL += " \
    docker-credential-helper-fio \
    docker \
    python3-docker \
    python3-docker-compose \
"

EXTRA_USERS_PARAMS += "\
usermod -a -G docker ${LMP_USER}; \
"
