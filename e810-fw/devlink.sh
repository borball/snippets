#!/bin/bash
#
# SPDX-License-Identifier: BSD-3-Clause
# Copyright (C) 2022, Intel Corporation
#
# This scipt is for automating the process of updating an NVM image using devlink interface on E810 products
#
#   ./devlink.sh <ethX>


usage()
{
  echo
  echo "Usage: $0 <interface>"
  echo
  exit 1
}


PF=$1
case "$PF" in
  "") usage;;
  -h|--help) usage;;
esac


# exit when any command fails
set -e


# default config file is nvmupdate.cfg from the NVMUpdate package downloaded
NVMCONFIG="nvmupdate.cfg"




#1. get the EEPID/eetrack ID of the NIC to be updated
EEPID=$(ethtool -i $PF | grep firmware-version | cut -d ' ' -f 3)
# strip hex '0x' prefix
EEPID="${EEPID#0x}"


echo "current EEPID: "$EEPID


#2. get the PCI info
PCI=$(ethtool -i $PF | grep bus | cut -d " " -f 2)


echo "PCI info: $PCI"


VENDOR=$(lspci -s $PCI -n | cut -d ':' -f 3)
VENDOR="$(echo $VENDOR | sed -e 's/\r//g')"
DEVICE=$(lspci -s $PCI -n | cut -d ':' -f 4)
DEVICE="${DEVICE:0:4}"
DEVICE_REV=$(lspci -s $PCI -n | cut -d ':' -f 4 | cut -d ' ' -f 3)
DEVICE_REV="${DEVICE_REV::-1}"


SUBVENDOR=$(lspci -s $PCI -nv | grep -i 'subsystem' | cut -d ':' -f 2)
SUBVENDOR="$(echo $SUBVENDOR | sed -e 's/\r//g')"
SUBDEVICE=$(lspci -s $PCI -nv | grep -i 'subsystem' | cut -d ':' -f 3)
SUBDEVICE=$(echo $SUBDEVICE | sed -e 's/\r//g')


echo "4-part ID is: vendor:"$VENDOR"; device:"$DEVICE"; subvendor:"$SUBVENDOR";subdevice:"$SUBDEVICE
echo "device rev: "$DEVICE_REV


DEVICE_INFO=$(echo "DEVICE: "$DEVICE)
SUBDEVICE_INFO=$(echo "SUBDEVICE: "$SUBDEVICE)
DEVICE_REV_INFO=$(echo "REVISION: "$DEVICE_REV)




#3. find the matching BIN file in nvmupdate.cfg based on the current EEPID
#NEW_EEPID=$(egrep -n -i -C 8 $EEPID $NVMCONFIG | grep "EEPID" |cut -d ' ' -f 2 )
NEW_EEPID=$(grep -n -i -C 10 "$DEVICE_INFO" $NVMCONFIG  | grep -n -i -C 9 "$SUBDEVICE_INFO" | grep -n -i -C 8 "$DEVICE_REV_INFO" | grep "EEPID" | cut -d ' ' -f 2)


# if no new EEPID can be found, exit
if [ -z "$NEW_EEPID" ]; then
  echo "no new EEPID found, update is not available, exit"
  exit 1
fi


# covert to lowercase for comparison
NEW_EEPID="${NEW_EEPID,,}"


echo "new EEPID: "$NEW_EEPID


#if the new EEPID and the current EEPID are the same, no need to do an update, exit
if [[ "$NEW_EEPID" == "$EEPID" ]]; then
  echo "curent NVM image is up to date, exit..."
  exit 1
fi


BIN_FILE=$(grep -n -i -C 10 "$DEVICE_INFO" $NVMCONFIG  | grep -n -i -C 9 "$SUBDEVICE_INFO" | grep -n -i -C 8 "$DEVICE_REV_INFO" | grep "NVM IMAGE" | cut -d ' ' -f 3)


echo "BIN_FILE: $BIN_FILE"


#BIN_FILE=$(egrep -n -i -C 8 $EEPID $NVMCONFIG | grep "NVM IMAGE" |cut -d ' ' -f 3)
BIN_FILE=$(echo $BIN_FILE | sed -e 's/\r//g')


echo "new BIN_FILE/NVM found: "$BIN_FILE


#4. set the path for devlink flash to where the .bin file is
FW_PATH=$(echo -n `pwd` | tee /sys/module/firmware_class/parameters/path)


echo "devlink fw update path: "$FW_PATH


#5. update to the new NVM
echo "Do the flash update now"
echo "devlink dev flash pci/$PCI file $BIN_FILE"


devlink dev flash "pci/$PCI" file $BIN_FILE