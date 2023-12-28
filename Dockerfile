ARG PACKER_VERSION=1.10.0
FROM hashicorp/packer:$PACKER_VERSION

LABEL maintainer="Marcos Diez <marcos AT unitron.com.br"

RUN apk update
RUN apk add --no-cache ansible py-pip openssh openssl libcurl

RUN addgroup -g 1000 -S container && adduser -u 1000 -s /bin/ash -G container -D container

RUN wget https://github.com/benkehoe/aws-whoami-golang/releases/download/v2.6.0/aws-whoami-v2.6.0-linux-amd64.tar.gz -O /tmp/aws-whoami-v2.6.0-linux-amd64.tar.gz
RUN cd /tmp;tar zfxv /tmp/aws-whoami-v2.6.0-linux-amd64.tar.gz
RUN mv /tmp/aws-whoami /bin

# this library is needed for aws-whoami to work
RUN apk add --no-cache gcompat libc6-compat libstdc++
RUN ln -s /lib/libc.so.6 /usr/lib/libresolv.so.2

USER container

RUN ansible-galaxy install git+https://github.com/ansible-lockdown/AMAZON2-CIS.git
RUN ansible-galaxy install git+https://github.com/ansible-lockdown/RHEL9-CIS.git
RUN ansible-galaxy install git+https://github.com/ansible-lockdown/UBUNTU22-CIS.git

RUN packer plugins install github.com/hashicorp/amazon
RUN packer plugins install github.com/hashicorp/ansible

ENTRYPOINT ["/bin/packer"]
