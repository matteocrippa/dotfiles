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

echo_info "Preparing system"

pacstrap -i /mnt base base-devel
genfstab -U /mnt > /mnt/etc/fstab
arch-chroot /mnt /bin/bash

echo_info "Setup system"

echo "en_US.UTF-8 UTF-8" >  /etc/locale.gen
locale-gen
rm /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Rome /etc/localtime
hwclock --systohc --utc
echo "arch" > /etc/hostname
passwd
echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
echo "Server = https://www.archlinux.org/mirrorlist/" >> /etc/pacman.d/mirrorlist
pacman -Sy intel-ucode
pacman -Syd dialog wpa_supplicant

echo_info "Bootloader"

sed -i "s/HOOKS/#HOOKS/g" /etc/mkinitcpio.conf
echo "HOOKS=(base udev autodetect keyboard keymap modconf block encrypt lvm2 filesystems fsck)" >> /etc/mkinitcpio.conf
mkinitcpio -p linux
bootctl --path=/boot install
vi /boot/loader/loader.conf
echo "default arch" > /boot/loader/loader.conf
echo "editor 0" >> /boot/loader/loader.con
echo "title Arch Linux" > /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /intel-ucode.img" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf
PART_ID=$(blkid -o value -s UUID /dev/mapper/nvme_group-root)
echo "options cryptdevice=UUID=${PART_ID}:cryptlvm root=/dev/mapper/nvme_group-root quiet rw" >> /boot/loader/entries/arch.conf

echo_info "Prepare reboot"
exit
umount -R /mnt
reboot
