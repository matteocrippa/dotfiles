#!/bin/bash

NVME=/dev/sda
SSD=/dev/sdb

echo "GPT"

# prepare nvme
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | sudo gdisk $NVME
  x # expert mode
  z # wipe disk
  y # confirm
  y # confirm
EOF

# prepare nvme
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | sudo gdisk $SSD
  x # expert mode
  z # wipe disk
  y # confirm
  y # confirm
EOF

# format disk ssd for home
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | sudo gdisk $SSD
  o # clear the in memory partition table
  y # confirm cleanup
  n # new partition
  1 # partition number 1
    # default - start at beginning of disk 
    # 100 MB boot parttion
  8E00 # filesystem type
  w # write the partition table
  y # confirm
EOF

# format disk nvme for swap and root
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | sudo gdisk $NVME
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

echo "LVM"

sudo cryptsetup luksFormat /dev/sda2
sudo cryptsetup open --type luks /dev/sda2 foo
sudo pvcreate /dev/mapper/foo
sudo vgcreate foo_group /dev/mapper/foo
sudo lvcreate -L32G  foo_group -n swap
sudo lvcreate -l 100%FREE foo_group -n root

sudo cryptsetup luksFormat /dev/sdb1
sudo cryptsetup open --type luks /dev/sdb1 bar
sudo pvcreate /dev/mapper/bar
sudo vgcreate bar_group /dev/mapper/bar
sudo lvcreate -l 100%FREE bar_group -n home

echo "Formatting"
