#!/bin/bash
# exit when any command fails
set -e

# set image name
ORG_NAME="zatitech/"
IMAGE_NAME=${ORG_NAME}"assuremappingtools"

# download NVIDIA Driver
version="$(glxinfo | grep "OpenGL version string" | rev | cut -d" " -f1 | rev)"
wget http://us.download.nvidia.com/XFree86/Linux-x86_64/"$version"/NVIDIA-Linux-x86_64-"$version".run
mv NVIDIA-Linux-x86_64-"$version".run NVIDIA-DRIVER.run

# use git to set the image tag based on git tag information
DESCRIBE=`git describe --tags --always`
GVERSION=`echo $DESCRIBE | awk '{split($0,a,"-"); print a[1]}'`
GBUILD=`echo $DESCRIBE | awk '{split($0,a,"-"); print a[2]}'`
HBUILD=`echo $DESCRIBE | awk '{split($0,a,"-"); print a[3]}'`
if [ "$GBUILD" -gt "0" ]; then
    GBUILD=-$GBUILD-$HBUILD
fi
TAG=$GVERSION$GBUILD

# use git to check ifit is master branch tag it as latest after the build
branch_name=$(git symbolic-ref -q HEAD)
branch_name=${branch_name##refs/heads/}
branch_name=${branch_name:-HEAD}

if [ -z "$TAG" ]
then
    echo "git desscribe --tags, returns nothing. checking if master to tag as latest!"
else
    echo "Building tagged version ${TAG}"
    docker build -t ${IMAGE_NAME}:${TAG} .
fi

if [ "$branch_name" = "master" ]; then
    echo "Current branch is master, building tagged version latest"
    docker build -t ${IMAGE_NAME}:latest .
fi