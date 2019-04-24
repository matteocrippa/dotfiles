#!/bin/bash

echo "Formatting"

# format disk nvme for swap and root
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | sudo gdisk /dev/sda
  o # clear the in memory partition table
  y # confirm cleanup
  n # new partition
  1 # partition number 1
    # default - start at beginning of disk 
  +256MB # 100 MB boot parttion
  EF00
  n # new partition
  2 # partion number 2
    # default, start immediately after preceding partition
    # default, extend partition to end of disk
  8E00 # make a partition bootable
  w # write the partition table
  y # confirm
EOF

# format disk ssd for home
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | sudo gdisk /dev/sdb
  o # clear the in memory partition table
  y # confirm cleanup
  n # new partition
  1 # partition number 1
    # default - start at beginning of disk 
    # 100 MB boot parttion
  8E00
  w # write the partition table
  y # confirm
EOF

echo "LVM"

cryptsetup luksFormat /dev/sda2
cryptsetup open --type luks /dev/sda2 foo
pvcreate /dev/mapper/foo
vgcreate foo_group /dev/mapper/foo
lvcreate -L32G  foo_group -n swap
lvcreate -l 100%FREE foo_group -n root

cryptsetup luksFormat /dev/sdb1
cryptsetup open --type luks /dev/sdb1 bar
pvcreate /dev/mapper/bar
vgcreate bar_group /dev/mapper/bar
lvcreate -l 100%FREE bar_group -n home
