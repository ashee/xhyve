#!/bin/sh

# Linux
KERNEL="./vmlinuz-3.10.0-514.el7.x86_64"
INITRD="./initramfs-3.10.0-514.el7.x86_64.img"
CMDLINE="earlyprintk=serial console=ttyS0 acpi=off root=/dev/mapper/cl-root ro crashkernel=auto rd.lv.lv=cl/root rd.lvm=cl/swap rhgb quiet LANG=en_US.UTF8"
# CMDLINE="earlyprintk=serial quiet console=ttyS0 acpi=off root=/dev/mapper/centos-root rd.lvm.lv=centos/root rd.lvm.lv=centos/swap rw"

MEM="-m 4G"
#SMP="-c 2"
NET="-s 2:0,virtio-net"
IMG_HDD="-s 4,virtio-blk,./hdd.img"
PCI_DEV="-s 0:0,hostbridge -s 31,lpc"
LPC_DEV="-l com1,stdio"
UUID="-U C6F3DC8D-5432-41DA-BD98-22E70AFD32E4"
sudo xhyve $ACPI $MEM $SMP $PCI_DEV $LPC_DEV $NET $IMG_CD $IMG_HDD $UUID \
  -f kexec,$KERNEL,$INITRD,"$CMDLINE"
