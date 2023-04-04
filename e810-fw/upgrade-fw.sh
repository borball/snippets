#!/bin/bash
# 
# This scipt will trigger a fw upgrade with devlink on SNO platform

usage(){
  echo
  echo "Usage: $0 <interface>"
  echo
  exit 1
}

prepare(){
	if [ $(/usr/bin/rpm-ostree status |grep 'Unlocked: development'|wc -l) -lt 1 ]; then
		echo "Will run rpm-ostree usroverlay"
		/usr/bin/rpm-ostree usroverlay
	else
		echo "Deployment is already in unlocked state: development"
	fi
}


# exit when any command fails
set -e
basedir="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

PF=$1
case "$PF" in
  "") usage;;
  -h|--help) usage;;
esac


prepare
$basedir/devlink.sh $PF

echo "Will reboot the node."

systemctl reboot