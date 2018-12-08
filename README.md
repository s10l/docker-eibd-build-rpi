# docker-eibd-rpi-build
Build eibd for the RaspberryPI on x64 Platform

Offers the possibility to build EIBD from BCUSDK for the RaspberryPI on x64 Platform.

## Prerequisites
You need to have docker installed on your system.

## Build BCUSDK

### On Windows
```
mkdir c:\target
docker pull s10l/eibd-rpi-build
docker run -it -v C:\target:/eibdbuild/build/bin s10l/eibd-rpi-build /build.sh
```

### On Linux
```
mkdir /tmp/target
docker pull s10l/eibd-rpi-build
docker run -it -v /tmp/target:/eibdbuild/build/bin s10l/eibd-rpi-build /build.sh
```

## Note
This is not based on my own work and was inspired by following previous work:

dockerfile from
https://hub.docker.com/r/tekn0ir/eibd/~/dockerfile/
 
cross compile build script from
https://michlstechblog.info/blog/raspberry-pi-cross-compiling-the-knxeib-eibd/