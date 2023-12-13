#!/bin/bash

if [[ "$1" == "-h" ]]; then
  echo "$0 [<core ranges>]"
  echo ""
  echo "$0 0,31-33,63"
  exit 0
fi

if [[ -n "$1" ]]; then
  cpu_list=($(echo "$1" | tr , '\n'|awk -F - 'NF==2{for(i=$1;i<=$2;i++) print i} NF==1{print $1}'| paste -d " " -s -))
else
  cpu_list=($(cat /proc/cmdline |tr ' ' '\n' |grep systemd.cpu_affinity | cut -d = -f 2| tr , " "))
fi

cpu_mask=0
for cpu in "${cpu_list[@]}"; do
cpu_bit=$((1 << $cpu))
cpu_mask=$(($cpu_mask | $cpu_bit))
done
printf '%016llx\n' "$cpu_mask" |sed -r -e 's/^.{8}/&,/'