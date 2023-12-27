# docker-packer-ansible
A docker image to run [`Packer`](https://packer.io) command line program with
[Ansible provisioner](https://www.packer.io/docs/provisioners/ansible/ansible) support.

## Usage

You can use this version with the following:
```shell
docker run <args> marcosdiez/packer-ansible:latest <command>
```

### Running a build:

The easiest way to run a command that references a configuration with one or
more template files, is to mount a volume for the local workspace.

Running `packer init`
```shell
docker run \
    -v `pwd`:/workspace -w /workspace \
    -e PACKER_PLUGIN_PATH=/workspace/.packer.d/plugins \
    marcosdiez/packer-ansible:latest \
    init .
```

## Dockerhub

We push images to https://hub.docker.com/repository/docker/marcosdiez/packer-ansible .

