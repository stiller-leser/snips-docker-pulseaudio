FROM ubuntu:18.04
MAINTAINER Guy Taylor <thebigguy.co.uk@gmail.com>

RUN apt-get update && apt-get install --yes gnupg ca-certificates lsb-release apt-transport-https

RUN echo "deb https://debian.snips.ai/stretch stable main" > /etc/apt/sources.list.d/snips.list \
    && apt-key adv --keyserver pgp.mit.edu --recv-keys F727C778CCB0A455 \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --yes sudo unzip systemd pulseaudio-utils openssh-server alsa-utils nano curl unzip python-pip git snips-platform-voice snips-tts snips-template snips-skill-server snips-watch

RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

RUN echo "root:snips" | chpasswd

COPY pulse-client.conf /etc/pulse/client.conf
COPY run.sh /run.sh

RUN chmod +x /run.sh

# run
CMD ["/bin/bash","-l","-c","sh /run.sh"]
