#!/bin/bash

. distro.sh

echo "LVM"

# NvMe
cryptsetup luksFormat ${NVME}2
cryptsetup open --type luks ${NVME}2 foo
pvcreate /dev/mapper/foo
vgcreate foo_group /dev/mapper/foo
lvcreate -L32G  foo_group -n swap
lvcreate -l 100%FREE foo_group -n root

# SSD
cryptsetup luksFormat ${SSD}1
cryptsetup open --type luks ${SSD}1 bar
pvcreate /dev/mapper/bar
vgcreate bar_group /dev/mapper/bar
lvcreate -l 100%FREE bar_group -n home

echo "Formatting"

# NvME
mkfs.fat ${NVME}1
mkfs.ext4 /dev/mapper/foo_group-root
mkswap /dev/mapper/foo_group-swap

# SSD
mkfs.ext4 /dev/mapper/bar_group-home

echo "Mounting"

# NvME
# mount /dev/mapper/foo_group-root /mnt
swapon /dev/mapper/foo_group-swap
mkdir /mnt/boot
mount ${NVME}1 /mnt/boot

# SSD
# mkdir /mnt/home
# mount /dev/mapper/bar_group-home /mnt/home

# Setup
setup
