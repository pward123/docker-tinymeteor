FROM    ubuntu:14.04
ENV     DEBIAN_FRONTEND noninteractive
RUN     apt-get update -y
RUN     apt-get install -y \
           bc \
           build-essential \
           cpio \
           rsync \
           unzip \
           locales \
           python-pip \
           wget
RUN     locale-gen en_US.UTF-8
RUN     dpkg-reconfigure locales
ADD     . /tmp/build/
WORKDIR /tmp/build
