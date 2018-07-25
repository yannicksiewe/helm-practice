FROM centos:7

MAINTAINER SYI <ysi@adorsys.de>

## Install docker client
RUN yum install -y docker-client \
    && yum clean all -y

## Install ansible and java 8
RUN yum install -y epel-release \
    && yum install -y openssh-clients git ansible python-six python-passlib python-lxml pyOpenSSL python-cryptography \
        patch httpd-tools java-1.8.0-openjdk-headless python-boto python-boto3 \
    && rm -rf /var/cache/yum \
    && yum clean all -y

## Install kubernetes helm
RUN curl -LsSf -O https://storage.googleapis.com/kubernetes-helm/helm-v2.9.1-linux-amd64.tar.gz \
    && tar -zxvf helm-v2.9.1-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/helm

ENTRYPOINT ["/usr/bin/ansible-playbook"]