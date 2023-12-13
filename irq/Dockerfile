# SPDX-License-Identifier:
# Copyright (c) 2023 Intel Corporation

FROM registry.access.redhat.com/ubi8/ubi

RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
    && yum -y install jq \
    && yum clean all \
    && rm -rf /var/cache/yum

WORKDIR /

COPY irqbalance-fix.sh /

USER root
USER 1001
