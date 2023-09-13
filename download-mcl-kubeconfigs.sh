#!/bin/bash

for spoke in $(oc get mcl -o jsonpath={..metadata.name} -l '!local-cluster')
do
  echo "------------------------------------------------"
  echo "download kubeconfig of cluster ${spoke} into file: kubeconfig-${spoke}.yaml"
  oc get secret -n ${spoke} ${spoke}-admin-kubeconfig -o jsonpath={.data.kubeconfig} |base64 -d > kubeconfig-${spoke}.yaml
  oc get clusterversion --kubeconfig=kubeconfig-${spoke}.yaml
done

echo
ls -lrt kubeconfig-*.yaml
