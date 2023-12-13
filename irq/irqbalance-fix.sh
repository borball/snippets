#!/bin/bash

cpu_manager_state_file="/var/lib/kubelet/cpu_manager_state"

if [[ -a $cpu_manager_state_file ]]; then
  cat $cpu_manager_state_file |jq
  cpu_cores=$(cat $cpu_manager_state_file|jq -r '.. |.baseband? |select(. != null)')
  echo "baseband cpu cores: $cpu_cores"
  if [[ -n $cpu_cores ]]; then
    cpu_list=($(echo "$cpu_cores" | tr , '\n'|awk -F - 'NF==2{for(i=$1;i<=$2;i++) print i} NF==1{print $1}'| paste -d " " -s -))
    cpu_mask=0
    for cpu in "${cpu_list[@]}"; do
      cpu_bit=$((1 << $cpu))
      cpu_mask=$(($cpu_mask | $cpu_bit))
    done
    banned_cpus_mask=$(printf '%016llx\n' "$cpu_mask" |sed -r -e 's/^.{8}/&,/')
    current_banned_cpus_str=$(grep ^IRQBALANCE_BANNED_CPUS /etc/sysconfig/irqbalance)
    update_banned_cpus_str="IRQBALANCE_BANNED_CPUS=\"$banned_cpus_mask\""
    if [[ "$current_banned_cpus_str" = "$update_banned_cpus_str" ]]; then
      echo "no update in /etc/sysconfig/irqbalance"
    else
      echo "will update to $banned_cpus_mask in /etc/sysconfig/irqbalance"
      sed -i "s/^IRQBALANCE_BANNED_CPUS.*/$update_banned_cpus_str/" /etc/sysconfig/irqbalance
    fi
  fi
fi

