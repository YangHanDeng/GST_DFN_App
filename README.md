# Gst_DFN_Shell
## About me
This is a package about using DeepFilterNet on Gstreamer with shell script

DeepFilterNet is a Deep Learning Model for Denoising purposes: [Github](https://github.com/Rikorose/DeepFilterNet/tree/main)

Gstreamer is a tool for streaming: [Official Page](https://gstreamer.freedesktop.org/documentation/?gi-language=c)
## Docker
To run the docker, we have to make pulseaudio and NVIDIA GPU available to container
- [setup pulseaudio]((https://github.com/mviereck/x11docker/wiki/Container-sound:-ALSA-or-Pulseaudio))
- [setup Nvidia GPU](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)
- run:
    ```
    Hostip="$(ip -4 -o a| grep docker0 | awk '{print $4}' | cut -d/ -f1)"

    docker run --rm --name pulsecontainer --env PULSE_SERVER=tcp:$Hostip:34567 \
        --gpus all --runtime=nvidia \
        imagename

    Containerip="$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' pulsecontainer)

    pactl load-module module-native-protocol-tcp  port=34567 auth-ip-acl=$Containerip
    ```
## Use the shell directly on your machine
1. cd DFN-Shell
2. ./install.sh
3. run the DFN_pipeline.sh
    ```
    Usage: ./DFN_pipeline.sh -i Input -o Output
            -i: Stream URL/"Mic"/File
                    To play a file: use FILE:///PATH_TO_FILE/FILENAME
                    To use microphone, use "mic"
            -o: "Device"/File
                    To write into the file, use relative/ absolute path.
                    To play on sound device, use "device".
    ```
