# Docker packages
CORE_IMAGE_BASE_INSTALL += " \
    docker \
    docker-credential-helper-fio \
    docker-compose \
"

EXTRA_USERS_PARAMS += "\
groupadd docker; \
usermod -a -G docker ${LMP_USER}; \
"
