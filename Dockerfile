# ARG PACKER_VERSION=1.10.0
# FROM hashicorp/packer:$PACKER_VERSION

# nothing works with alpine, sorry

FROM ubuntu:22.04

LABEL maintainer="Marcos Diez <marcos AT unitron.com.br>"

RUN apt-get update
ARG DEBIAN_FRONTEND=noninteractive
# RUN apt-get install -y ansible curl awscli nano packer sudo git
RUN apt-get install -y curl awscli nano sudo git unzip python3-pip
RUN pip3 install ansible boto3 crowdstrike-falconpy

RUN groupadd --gid 1000 ubuntu && useradd --uid 1000 --gid 1000 -m ubuntu

RUN curl https://releases.hashicorp.com/packer/1.10.0/packer_1.10.0_linux_amd64.zip > /tmp/packer.zip
RUN apt-get install unzip
RUN unzip /tmp/packer.zip -d /tmp
RUN mv /tmp/packer /usr/bin/packer
RUN rm /tmp/packer.zip

# if you don't do that, guess what, the crowdstrike ansible module fails
RUN echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' | tee -a  /etc/sudoers

USER ubuntu

RUN ansible-galaxy install git+https://github.com/ansible-lockdown/AMAZON2-CIS.git
RUN ansible-galaxy install git+https://github.com/ansible-lockdown/RHEL9-CIS.git
RUN ansible-galaxy install git+https://github.com/ansible-lockdown/UBUNTU22-CIS.git

# RUN packer --version
RUN packer plugins install github.com/hashicorp/amazon
RUN packer plugins install github.com/hashicorp/ansible


# # ENTRYPOINT ["/bin/packer"]
