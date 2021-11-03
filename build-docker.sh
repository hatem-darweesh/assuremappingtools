#!/bin/bash
# exit when any command fails
set -e

# set image name
ORG_NAME="zatitech/"
IMAGE_NAME=${ORG_NAME}"assuremappingtools"

# use git to check ifit is master branch tag it as latest after the build
branch_name=$(git symbolic-ref -q HEAD)
branch_name=${branch_name##refs/heads/}
branch_name=${branch_name:-HEAD}

echo "Building tagged version ${branch_name}"
docker build -t ${IMAGE_NAME}:${branch_name} .
