#!/bin/bash
if [[ -z $1 ]]
then
    echo "usage $0 NUMBER"
    exit 1
fi
docker build . --push --progress plain -t marcosdiez/packer-ansible:v0.0.$1
