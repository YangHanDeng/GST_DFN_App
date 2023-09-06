#!/bin/bash

ubuntu_version=$(lsb_release -a 2>/dev/null | grep Description | cut -f 2 -d ' ')

apt install -qqy python3-pip curl git

# if we need to sink rtsp
# sudo apt install gstreamer1.0-rtsp

apt-get install -qqy libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio gstreamer1.0-python3-plugin-loader

rust=$(rustc --version 2>/dev/null)
if [[ -z $rust ]]; then
	curl https://sh.rustup.rs -sSf | sh -s -- -y
	source "$HOME/.cargo/env"
fi

pip install -q deepfilternet

if [[ $ubuntu_version == 20.04* ]]
then
	cd ./plugin/python
	tar zxvf DFN_20.04.tar.gz
	cd ../../
elif [[ $ubuntu_version == 22.04* ]]
then
	cd ./plugin/python
	tar zxvf DFN_22.04.tar.gz
	cd ../../
else
	echo "Untested Ubuntu Version, only tested on Ubuntu 20.04 and 22.04"
	return 1
fi
echo ""
echo "export GST_PLUGIN_PATH=$PWD/plugin:$GST_PLUGIN_PATH" >> $HOME/.bashrc
echo "export PATH=\$PWD:$PATH" >> $HOME/.bashrc
echo "To get started you may need to restart your current shell."
echo "This will reload your GST_PLUGIN_PATH and PATH"
echo "To configure your current shell, run:"
echo "export GST_PLUGIN_PATH=\$PWD/plugin:\$GST_PLUGIN_PATH"
echo "export GST_PLUGIN_PATH=\$PWD:\$PATH"
echo ""

ptexist=$(pip list | grep torch)
if [[ -z $ptexist ]]; then
	echo "please install your own pytorch to move forward"
fi


