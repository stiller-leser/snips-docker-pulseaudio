docker run -d \
    -v /dev/shm:/dev/shm \
    -v /run/user/0/pulse:/run/user/1000/pulse \
    -v /var/lib/dbus:/var/lib/dbus \
    -v ~/.pulse:/home/root/.pulse \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    --privileged \
    --mac-address b8:27:eb:ae:87:c6 \
    snips-docker-audio
