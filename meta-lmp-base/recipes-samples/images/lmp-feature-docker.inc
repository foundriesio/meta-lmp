# Docker packages
CORE_IMAGE_BASE_INSTALL += " \
    docker-ce \
    docker-credential-helper-fio \
    python3-docker \
    python3-docker-compose \
"

EXTRA_USERS_PARAMS += "\
usermod -a -G docker ${LMP_USER}; \
"
