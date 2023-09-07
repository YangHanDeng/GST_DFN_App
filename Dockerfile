FROM ubuntu:22.04
MAINTAINER Docker Henry <yanghand@uci.edu>

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -qq update && apt-get -qqy install lsb-core
COPY DFN-App DFN-App
WORKDIR DFN-App
RUN chmod +x *.sh && ./install.sh
RUN pip install -q torch torchvision torchaudio

ENV PATH="$PATH:/DFN-App"
ENV GST_PLUGIN_PATH="/DFN-App/plugin"
CMD ["DFN_App"]