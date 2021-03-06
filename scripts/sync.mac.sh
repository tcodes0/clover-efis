#! /usr/local/bin/bash

bailout() {
  echo "$@"
  exit
}

set -x

RSYNC="rsync -rtvvuc"
z170_PATH="./z170/EFI/"
z170_DEVICE="disk0s1"
z390_PATH="./z390/EFI/"
z390_DEVICE="disk0s1"

if ioreg -l | grep -q iMac17,1; then
  FROM="$z170_PATH"
  DEVICE="$z170_DEVICE"
fi
if ioreg -l | grep -q iMac19,1; then
  FROM="$z390_PATH"
  DEVICE="$z390_DEVICE"
fi
if [ ! "$FROM" ]; then
  bailout "failed to detect motheboard folder to use"
fi

if ! diskutil info "$DEVICE" | grep -q -E "Mounted:[ ]+Yes"; then
  echo "device not mounted, mounting..."
  sudo diskutil mount "$DEVICE"
fi
MOUNTPOINT=$(diskutil info "$DEVICE" | sed -nE "/Mount\ Point/p" | sed -E "s/   Mount[ ]Point:[ ]+([^ ]+)/\1/g")
if [ ! "$MOUNTPOINT" ]; then
  bailout "mountpoint detection problem"
fi
if [ ! -d "${MOUNTPOINT}/EFI" ]; then
  bailout "mountpoint has no EFI folder"
fi

eval "$RSYNC $FROM ${MOUNTPOINT}/EFI"

set +x
