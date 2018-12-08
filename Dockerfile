# this is not based on my own work and was inspired by following previous work:
#
# dockerfile from
# https://hub.docker.com/r/tekn0ir/eibd/~/dockerfile/
# 
# cross compile build script from
# https://michlstechblog.info/blog/raspberry-pi-cross-compiling-the-knxeib-eibd/

FROM debian:jessie
MAINTAINER s10l <s10l@github.com>

# update apt and install dependencies
RUN apt-get -qq update
RUN apt-get install -y python python-dev python-pip python-virtualenv unzip git lib32z1 lib32ncurses5 lib32z1-dev
RUN apt-get install -y build-essential gcc git rsync cmake make g++ binutils automake flex bison patch wget

# download dependencies
RUN mkdir -p /eibdbuild/raspPiTools && cd /eibdbuild/raspPiTools && git clone git://github.com/raspberrypi/tools.git
RUN mkdir -p /eibdbuild/pthsem && cd /eibdbuild/pthsem && wget http://www.auto.tuwien.ac.at/~mkoegler/pth/pthsem_2.0.8.tar.gz
RUN mkdir -p /eibdbuild/bcusdk && cd /eibdbuild/bcusdk && wget http://netcologne.dl.sourceforge.net/project/bcusdk/bcusdk/bcusdk_0.0.5.tar.gz

# create symbolic links
RUN ln -s /eibdbuild/raspPiTools/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/arm-linux-gnueabihf/libc/lib/ld-linux-armhf.so.3 /lib/ld-linux-armhf.so.3

# copy build script
COPY build.sh build.sh
RUN chmod +x build.sh

# entrypoint
ENTRYPOINT ["/bin/bash"]