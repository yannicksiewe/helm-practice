FROM centos:7

MAINTAINER SYI <ysi@adorsys.de>

## Install docker

RUN yum install -y docker-client

## Install ansible and ansible vault
RUN yum install -y epel-release \
    && yum install -y openssh-clients git ansible python-six python-passlib python-lxml pyOpenSSL python-cryptography \
        patch httpd-tools java-1.8.0-openjdk-headless python-boto python-boto3 \
    && rm -rf /var/cache/yum

## Install kubernete helm
RUN curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh \
    && chmod 700 get_helm.sh

RUN sh get_helm.sh

ENTRYPOINT ["/usr/bin/ansible-playbook"]