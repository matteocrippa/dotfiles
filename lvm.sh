#!/bin/bash

. distro.sh
. helpers.sh

# NvMe
echo_info "LVM + Formatting NVMe"
cryptsetup luksFormat ${NVME}2
cryptsetup open --type luks ${NVME}2 foo
pvcreate /dev/mapper/foo
vgcreate foo_group /dev/mapper/foo
lvcreate -L${SWAP}  foo_group -n swap
lvcreate -l 100%FREE foo_group -n root
mkfs.fat ${NVME}1
mkfs.ext4 /dev/mapper/foo_group-root
mkswap /dev/mapper/foo_group-swap

# SSD
echo_info "LVM + Formatting SSD"
cryptsetup luksFormat ${SSD}1
cryptsetup open --type luks ${SSD}1 bar
pvcreate /dev/mapper/bar
vgcreate bar_group /dev/mapper/bar
lvcreate -l 100%FREE bar_group -n home
mkfs.ext4 /dev/mapper/bar_group-home
F
echo_info "Mounting"

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
