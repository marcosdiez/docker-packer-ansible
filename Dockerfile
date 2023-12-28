ARG PACKER_VERSION=1.10.0
FROM hashicorp/packer:$PACKER_VERSION

LABEL maintainer="Marcos Diez <marcos AT unitron.com.br"

RUN apk update
RUN apk add --no-cache ansible py-pip openssh openssl libcurl

RUN ansible-galaxy install git+https://github.com/ansible-lockdown/AMAZON2-CIS.git
RUN ansible-galaxy install git+https://github.com/ansible-lockdown/RHEL9-CIS.git
RUN ansible-galaxy install git+https://github.com/ansible-lockdown/UBUNTU22-CIS.git

RUN packer plugins install github.com/hashicorp/amazon
RUN packer plugins install github.com/hashicorp/ansible


ENTRYPOINT ["/bin/packer"]
