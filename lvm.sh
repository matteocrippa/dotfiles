#!/bin/bash

. distro.sh
. helpers.sh

# NvMe
echo_info "LVM + Formatting NVMe"
cryptsetup luksFormat ${NVME}2
cryptsetup open --type luks ${NVME}2 nvme
pvcreate /dev/mapper/nvme
vgcreate nvme_group /dev/mapper/nvme
lvcreate -L${SWAP} nvme_group -n swap
lvcreate -l 100%FREE nvme_group -n root
mkfs.fat ${NVME}1
mkfs.ext4 /dev/mapper/nvme_group-root
mkswap /dev/mapper/nvme_group-swap

# SSD
echo_info "LVM + Formatting SSD"
cryptsetup luksFormat ${SSD}1
cryptsetup open --type luks ${SSD}1 ssd
pvcreate /dev/mapper/ssd
vgcreate ssd_group /dev/mapper/ssd
lvcreate -l 100%FREE ssd_group -n home
mkfs.ext4 /dev/mapper/ssd_group-home

echo_info "Mounting"

# NvME
mount /dev/mapper/nvme_group-root /mnt
swapon /dev/mapper/nvme_group-swap
mkdir /mnt/boot
mount ${NVME}1 /mnt/boot

# SSD
mkdir /mnt/home
mount /dev/mapper/ssd_group-home /mnt/home

pacstrap -i /mnt base base-devel
genfstab -U /mnt > /mnt/etc/fstab
arch-chroot /mnt /bin/bash
