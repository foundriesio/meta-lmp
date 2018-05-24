# Add /sbin & co to $PATH for normal users (useful for development)
[ "$USER" == "root" ] || PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin
