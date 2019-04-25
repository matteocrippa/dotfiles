#!/bin/bash

. distro.sh
. helpers.sh

echo_info "GPT"

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
dd if=/dev/urandom of=keyfile bs=1024 count=20
cryptsetup --key-file keyfile luksFormat ${SSD}1
cryptsetup --key-file keyfile luksOpen ${SSD}1 ssd
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
echo_info "> Mounted NVMe"

# SSD
mkdir /mnt/home
mount /dev/mapper/ssd_group-home /mnt/home
echo_info "> Mounted SSD"

echo_info "Setup keyfile decrypt"
cp keyfile /mnt/root/
export PART_ID=$(blkid -o value -s UUID ${SSD}1)
echo "crypt_hdd UUID=${PART_ID} /root/keyfile luks"

# System
echo_info "Preparing system"

pacstrap -i /mnt base base-devel
genfstab -U /mnt > /mnt/etc/fstab
arch-chroot /mnt /bin/bash
