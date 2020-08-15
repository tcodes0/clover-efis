#! /usr/local/bin/bash

bailout() {
  echo "$@"
  exit
}

# set -x

# --recursive
# --times preserve modification times
# --verbose
# --verbose
# --update skip files newer on receiver
# --checksum skip based on checksum
RSYNC="rsync --recursive --times --verbose --verbose --update --checksum"
z170_PATH="./z170/EFI/"
z390_PATH="./z390/EFI/"

if grep i7-6600K --quiet /proc/cpuinfo; then
  FROM="$z170_PATH"
fi
if grep i5-9600K --quiet /proc/cpuinfo; then
  FROM="$z390_PATH"
fi
if [ ! "$FROM" ]; then
  bailout "failed to detect motheboard folder to use"
fi

if ! grep '[/]boot' --quiet /proc/mounts; then
  bailout "nothing mounted at /boot"
fi
MOUNTPOINT='/boot'

if [ ! -d "${MOUNTPOINT}/EFI" ]; then
  bailout "mountpoint has no EFI folder"
fi

echo "Confirm EFI update: Folder $FROM $(sed -nE '/boot/p' /proc/mounts | sed -E 's/([/]dev[/]nvme0n1p1)\ ([/]boot).*/Device \1 mounted at \2/g') (y/n)
   ...defaulting to no in 10s"
if ! read -rt 10; then bailout 'timeout'; fi

if [ "$REPLY" == "n" ] || [ "$REPLY" == "no" ] || [ "$REPLY" == "N" ] || [ "$REPLY" == "NO" ]; then
  bailout "aborting"
fi

eval "$RSYNC $FROM ${MOUNTPOINT}/EFI"

# set +x
