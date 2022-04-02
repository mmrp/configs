#!/bin/sh

set -e
disk=${1?"provide disk"}
mount_pt=${2?"provide mount option"}
first_dev=$(losetup -f) 
losetup ${first_dev} ${disk} 
echo "press exit upon finishing operations"
mount ${disk} ${mount_pt}
bash
umount ${mount_pt}
losetup -d ${first_dev}
