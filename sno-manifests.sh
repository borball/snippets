#!/bin/bash

manifests_folder=/tmp/manifests/
manifests_file=$manifests_folder/sno-manifests.log

oc_output(){
  echo "$1" >> $manifests_file
  echo -e "$($1)" >> $manifests_file
  echo "" >> $manifests_file
}

info(){
  echo "$1" >> $manifests_file
}


machine_configs=("01-container-mount-namespace-and-kubelet-conf" "02-master-workload-partitioning" "04-accelerated-container-startup-master" "06-kdump-enable-master" "disable-chronyd")
pps=("sno-perfprofile")
tuneds=("performance-patch")


fetch_mc(){
  for mc in ${machine_configs[@]}; do
    if [ $(oc get mc |grep $mc | wc -l) -eq 1 ]; then
      oc get mc $mc -o yaml > "$manifests_folder/$mc.yaml"
    else
      info "MachineConfig $mc is not existing."
    fi
  done
}

fetch_pp(){
  for pp in ${pps[@]}; do
    if [ $(oc get performanceprofiles |grep $pp | wc -l) -eq 1 ]; then
      oc get performanceprofile $pp -o yaml > "$manifests_folder/$pp.yaml"
    else
      info "PerformanceProfile $pp is not existing."
    fi
  done
}

fetch_tuned(){
  for tuned in ${tuneds[@]}; do
    if [ $(oc get tuned -n  openshift-cluster-node-tuning-operator |grep $tuned | wc -l) -eq 1 ]; then
      oc get tuned -n  openshift-cluster-node-tuning-operator $tuned -o yaml > "$manifests_folder/$tuned.yaml"
    else
      info "Tuned $tuned is not existing."
    fi
  done
}

mkdir -p $manifests_folder
rm -f  $manifests_folder/*

oc_output "oc get nodes"
oc_output "oc get clusterversion"
oc_output "oc get co"
oc_output "oc get mc"

fetch_mc
fetch_pp
fetch_tuned

oc_output "oc get operator"
oc_output "oc get csv -A"
oc_output "oc get catalogsource -n openshift-marketplace"

oc get consoles.operator.openshift.io cluster -o yaml> $manifests_folder/console.yaml
oc get configmap -n openshift-monitoring cluster-monitoring-config -o yaml > $manifests_folder/cluster-monitoring-config.yaml
oc get network.operator.openshift.io cluster -o yaml > $manifests_folder/network.yaml

oc get -n openshift-ptp ptpconfig -o yaml > $manifests_folder/ptpc-onfig.yaml
oc get -n openshift-sriov-network-operator SriovNetwork,SriovNetworkNodePolicy --ignore-not-found -o yaml > $manifests_folder/sriov-networks.yaml

echo "Please find all manifests in folder $manifests_folder."