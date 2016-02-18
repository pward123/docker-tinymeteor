#!/usr/bin/env bash
set -e

imagename=tinymeteor

cdir=$(pwd)
source ./${imagename}_config

buildroot_dir=${cdir}/buildroot-${buildroot_version}
docker_dir=${cdir}/Docker

if [[ ! -d ${buildroot_dir} ]]
then
  curl ${buildroot_url} | tar jx
fi

# If the node package is 0.10.40, patch the buildroot to use 0.10.41
if [[ -d "${buildroot_dir}/package/nodejs/0.10.40" ]]
then
  echo "patching buildroot to support node 0.10.41"
  patch -p1 -i ../node_0.10.41.patch -d buildroot-2015.11.1
fi

cp ./${imagename}_defconfig ${buildroot_dir}/configs/${imagename}_defconfig

cd ${buildroot_dir} && make ${imagename}_defconfig && make
for package in "${packages[@]}"
do
    echo "building ${package}"
    make ${package}-rebuild
done
make

mv ${buildroot_dir}/output/images/rootfs.tar ${docker_dir}


