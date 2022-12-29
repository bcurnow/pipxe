#!/bin/bash

rootDir=$(dirname $0)
rootDir=$(cd ${rootDir}/.. && pwd)
imageName=$(cd ${rootDir} && basename $(pwd))

docker run --name ${imageName} --rm -it --cap-add=NET_ADMIN --net=host --mount src=/var/nas/pxe/tftp/os,target=/pxe/tftp/os,type=bind --mount src=/var/nas/pxe/tftp/pxelinux.cfg,target=/pxe/tftp/pxelinux.cfg,type=bind --mount src=${rootDir}/dnsmasq.conf,target=/etc/dnsmasq.conf,type=bind ${imageName}:latest
