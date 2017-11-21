#!/bin/sh
set -x 
KERNEL="$PWD/vmlinuz"
INITRD="$PWD/initrd.img"
CMDLINE="earlyprintk=serial console=ttyS0"

MEM="-m 1G"
SMP="-c 2"
NET="-s 2:0,virtio-net"
IMG_CD="-s 3,ahci-cd,${HOME}/Learning/xhyve/isos/CentOS-7-x86_64-Minimal-1611.iso"
IMG_HDD="-s 4,virtio-blk,$PWD/hdd.img"
PCI_DEV="-s 0:0,hostbridge -s 31,lpc"
LPC_DEV="-l com1,stdio"
sudo xhyve $ACPI $MEM $SMP $PCI_DEV $LPC_DEV $NET $IMG_CD $IMG_HDD $UUID -f kexec,$KERNEL,$INITRD,"$CMDLINE"
