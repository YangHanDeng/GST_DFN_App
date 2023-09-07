# DFN-App
## Installation
1. apt-get update && apt-get -y install lsb-core
2. chmod +x *.sh && ./install.sh
3. install your own pytorch
## DFN_pipeline.sh Usage
```
Usage: ./DFN_App.sh -i Input -o Output
         -i: Stream URL/"Mic"/File
                 To play a file: use FILE:///PATH_TO_FILE/FILENAME
                 To use microphone, use "mic"
         -o: "Device"/File
                 To write into the file, use relative/ absolute path.
                 To play on sound device, use "device".
```