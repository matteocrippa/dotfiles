#!/bin/bash

. distro.sh
. helpers.sh

sudo pacman -Sy gdisk

echo_info "GPT"

# prepare nvme
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | sudo gdisk $NVME
  x # expert mode
  z # wipe disk
  y # confirm
  y # confirm
EOF

# prepare ssd
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

# NvMe
echo_info "LVM + Formatting NVMe"
sudo cryptsetup luksFormat ${NVME}2
sudo cryptsetup open --type luks ${NVME}2 nvme
sudo pvcreate /dev/mapper/nvme
sudo vgcreate nvme_group /dev/mapper/nvme
sudo lvcreate -L${SWAP} nvme_group -n swap
sudo lvcreate -l 100%FREE nvme_group -n root
sudo mkfs.fat ${NVME}1
sudo mkfs.ext4 /dev/mapper/nvme_group-root
sudo mkswap /dev/mapper/nvme_group-swap

# SSD
echo_info "LVM + Formatting SSD"
sudo dd if=/dev/urandom of=keyfile bs=1024 count=20
sudo cryptsetup --key-file keyfile luksFormat ${SSD}1
sudo cryptsetup --key-file keyfile luksOpen ${SSD}1 ssd
sudo pvcreate /dev/mapper/ssd
sudo vgcreate ssd_group /dev/mapper/ssd
sudo lvcreate -l 100%FREE ssd_group -n home
sudo mkfs.ext4 /dev/mapper/ssd_group-home

echo_info "Mounting"

## NvME
echo_info "Setup keyfile decrypt"
sudo mount /dev/mapper/nvme_group-root /mnt
sudo cp keyfile /mnt
sudo umount -R /mnt
