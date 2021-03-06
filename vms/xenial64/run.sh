#!/bin/sh

# make sparse copy of fresh
# dd if=xenial_fresh.img of=xenial.img bs=64k conv=sparse


# KERNEL="$PWD/vmlinuz"
# INITRD="$PWD/initrd.gz"
# CMDLINE="earlyprintk=serial console=ttyS0 acpi=off"

KERNEL="./boot/vmlinuz-4.4.0-87-generic"
INITRD="./boot/initrd.img-4.4.0-87-generic"
CMDLINE="earlyprintk=serial console=ttyS0 root=/dev/vda1 ro"

MEM="-m 512M"
#SMP="-c 2"
NET="-s 2:0,virtio-net"
IMG_CD="-s 3:0,ahci-cd,$HOME/opt/downloads/ubuntu-16.04.3-server-amd64.iso"
# IMG_HDD="-s 4,virtio-blk,hdd.img"
# IMG_HDD="-s 4,virtio-blk,hdd.qcow2?sync=drive&buffered=1,format=qcow,qcow-config=discard=false;compact_after_unmaps=0;keep_erased=262144;runtime_asserts=false"
# IMG_HDD="-s 4:0,virtio-blk,file://$PWD/ubuntu_fresh.qcow2?sync=drive&buffered=1,format=qcow,qcow-config=discard=false;compact_after_unmaps=0;keep_erased=262144;runtime_asserts=false"
# IMG_HDD="-s 4:0,ahci-hd,file://$PWD/xenial64.qcow2,format=qcow"
# IMG_HDD="-s 4:0,virtio-blk,file://$PWD/xenial64.qcow2,format=qcow"
IMG_HDD="-s 4:0,virtio-blk,xenial.img"


PCI_DEV="-s 0:0,hostbridge -s 31,lpc"
LPC_DEV="-l com1,stdio"

UUID="-U 851DCA57-59FB-4523-8FC9-B3114F1E02FF"


# xhyve $MEM $SMP $PCI_DEV $LPC_DEV $NET $IMG_CD $IMG_HDD -f kexec,$KERNEL,$INITRD,"$CMDLINE"

# hyperkit -A -m 512M -s "0:0,hostbridge" -s "31,lpc" -l "com1,stdio" "$NET" "$IMG_CD" -s "4:0,ahci-hd,file://$PWD/hdd.qcow2,format=qcow" -f kexec,$KERNEL,$INITRD,"$CMDLINE"

hyperkit -A $MEM $PCI_DEV $LPC_DEV $NET $IMG_CD $IMG_HDD $UUID -f kexec,$KERNEL,$INITRD,"$CMDLINE"
