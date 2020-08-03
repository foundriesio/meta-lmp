# Docker packages
CORE_IMAGE_BASE_INSTALL += " \
    docker-ce \
    docker-app \
    docker-credential-helper-fio \
    python3-docker \
    python3-docker-compose \
    docker-image-preload \
"

EXTRA_USERS_PARAMS += "\
usermod -a -G docker ${LMP_USER}; \
"
