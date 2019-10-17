# DEPRECATED! Snips now provides their own: https://github.com/snipsco/snips-platform-docker

## Docker PulseAudio Example
Snips in a docker container with audio via PulseAudio. This is based on [docker-pulseaudio-example](https://github.com/TheBiggerGuy/docker-pulseaudio-example) and [snips-docker](https://github.com/dYalib/snips-docker). Since this is using PulseAudio, be sure that you have a running configuration.

## Dangers!
This docker container is running a full fledged SSH server (OpenSSH) in order to work with `sam`. Also it works `priviledged` meaning it has wide access to your system. Also it is big. Both facts are reasons, why I won't make this container availabe on docker hub. ONLY use this container for testing! 

## Building
```bash
./build_image.sh
```

## Running
```bash
./run_docker.sh
```

## Snips explanation
This is meant to simulate a Snips setup which can be addressed by `sam`. After building and running the container, it will show up when `sam devices` is run (the magic lies in the mac address of the container). You can then connect to it by running `sam connect IP-GOES-HERE` (user: root, password: snips) and init it by running `sam init`. Once inited setup the audio using `sam setup audio`. Then login to the console using `sam login` and install your assistant by running `sam install assistant -i ID-GOES-HERE`. Use `sam watch` to watch Snips. 

## PulseAudio explanation
Getting a PulseAudio app to work within a Docker container is harder than it looks. This example is designed to produce the smallest working configuration that can be used in your own containers.

To be clear this is designed so the app within the Docker container does not run a PulseAudio server. Instead the app connects as a client directly to the hosts PulseAudio server and uses it's configuration/devices to output the sound. This is achieved by mapping the UNIX socket used by PulseAudio in the host into the container and configuring its use.

BE AWARE: Since this is using the PulseAudio config of the root user (UID 0), this can still mess with your setup. If you do not want to use the PulseAudio daemon of the root user, change line 3 in `run_docker.sh` from `0` to `1000`. 

If you are using to root user in order to get it to work, you need to start the PulseAudio daemon (`sudo pulseaudio -D --system`). 

If you have troubles with sound, try deleting the `/root/.pulse` folder.

## Contributing
Feel free to fork this repository and submit PRs. Happy to work on them (in the end one good running setup is better than many barely running ones)
