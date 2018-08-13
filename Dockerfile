FROM centos:7

MAINTAINER SYI <ysi@adorsys.de>

## Install docker client
RUN yum install -y docker-client \
## Install oc client
    && curl -LsSf -O https://github.com/openshift/origin/releases/download/v3.10.0/openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit.tar.gz \
    && tar zxvf openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit.tar.gz  \
    && mv openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit/oc /usr/local/bin/  \
    && rm -rf openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit*  \
## Install ansible and java 8
    && yum install -y epel-release \
    && yum install -y openssh-clients git ansible \
    && rm -rf /var/cache/yum  \
## Install kubernetes helm
    && curl -LsSf -O https://storage.googleapis.com/kubernetes-helm/helm-v2.9.1-linux-amd64.tar.gz  \
    && tar -zxvf helm-v2.9.1-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && rm -rf helm-v2.9.1-linux-amd64.tar.gz linux-amd64 \
    && yum clean all -y

ENTRYPOINT ["/usr/bin/ansible-playbook"]