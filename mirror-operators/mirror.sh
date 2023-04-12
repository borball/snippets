#!/bin/bash
#

redhat_operator_index="registry.redhat.io/redhat/redhat-operator-index:v4.12"
local_operator_index="hub-helper:5000/olm/redhat-operator-index:v4.12" 

operators=("local-storage-operator" "ptp-operator" "sriov-network-operator" "performance-addon-operator" "odf-operator" "rook-ceph-operator" "mcg-operator" "ocs-operator" "kubernetes-nmstate-operator" "metallb-operator" "node-healthcheck-operator")

workspace=local-operator-index
mkdir -p $workspace/configs

for operator in ${operators[@]}; do
  opm render $redhat_operator_index| jq --arg operator $operator 'select( .package == $operator or .name == $operator )'  >> $workspace/configs/index.json
done

opm generate dockerfile $workspace/configs/
podman build -t $local_operator_index -f $workspace/configs.Dockerfile
podman push $local_operator_index

#test(install oc-mirror first: https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable-4.12/oc-mirror.tar.gz)
oc-mirror list operators --catalog $local_operator_index

# [root@hub-helper 4.12-mirror]# oc-mirror list operators --catalog hub-helper:5000/olm/redhat-operator-index:v4.12
# NAME                         DISPLAY NAME                 DEFAULT CHANNEL
# kubernetes-nmstate-operator  Kubernetes NMState Operator  stable
# local-storage-operator       Local Storage                stable
# mcg-operator                 NooBaa Operator              stable-4.12
# metallb-operator             MetalLB Operator             stable
# node-healthcheck-operator    Node Health Check Operator   stable
# ocs-operator                 OpenShift Container Storage  stable-4.12
# odf-operator                 OpenShift Data Foundation    stable-4.12
# ptp-operator                 PTP Operator                 stable
# sriov-network-operator       SR-IOV Network Operator      stable



