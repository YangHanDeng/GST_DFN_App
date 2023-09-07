FROM ubuntu:22.04
MAINTAINER Docker Henry <yanghand@uci.edu>

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -qq update && apt-get -qqy install lsb-core
COPY DFN-Shell DFN-Shell
WORKDIR DFN-Shell
RUN chmod +x *.sh && ./install.sh
RUN pip install -q torch torchvision torchaudio

ENV PATH="$PATH:$PWD"
ENV GST_PLUGIN_PATH="$PWD/plugin"
CMD ["DFN_pipeline"]