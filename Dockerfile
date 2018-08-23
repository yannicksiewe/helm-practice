FROM centos:7

MAINTAINER SYI <ysi@adorsys.de>

ARG COPY_IMAGE_VERSION=v2.0.0-rc.1
ARG HELM_VERSION=v2.10.0
ARG HELM_DIFF_VERSION=v2.9.0+2

RUN yum install -y epel-release centos-release-openshift-origin \
    && yum install -y git docker-client ansible origin-clients \
    && yum clean all \
    && rm -rf /var/cache/yum \
## Install kubernetes helm
    && curl -LsSf -O https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && tar -zxvf helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && rm -rf helm-${HELM_VERSION}-linux-amd64.tar.gz linux-amd64 \
## Install helm diff plugin
    && helm init --client-only \
    && helm plugin install https://github.com/databus23/helm-diff --version ${HELM_DIFF_VERSION} \
## Install copy-docker-image
    && curl -LsSf -o /usr/local/bin/copy-docker-image "https://github.com/jkroepke/copy-docker-image/releases/download/${COPY_IMAGE_VERSION}/copy-docker-image_linux_amd64" \
    && chmod +x /usr/local/bin/copy-docker-image