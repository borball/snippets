FROM registry.access.redhat.com/ubi9:9.1
MAINTAINER bzhai@redhat.com

RUN dnf install -y ethtool iproute pciutils && curl -LO https://downloadmirror.intel.com/769278/E810_NVMUpdatePackage_v4_20_Linux.tar.gz && tar xf E810_NVMUpdatePackage_v4_20_Linux.tar.gz && rm -f E810_NVMUpdatePackage_v4_20_Linux.tar.gz

COPY devlink.sh /E810/Linux_x64/devlink.sh
COPY fw-upgrade.sh /E810/Linux_x64/fw-upgrade.sh
CMD ["/E810/Linux_x64/fw-upgrade.sh"]