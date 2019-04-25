#!/bin/bash

. distro.sh
. helpers.sh

echo_info "Setup system"

echo "en_US.UTF-8 UTF-8" >  /etc/locale.gen
locale-gen
rm /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Rome /etc/localtime
hwclock --systohc --utc
echo "arch" > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "127.0.0.1 arch.localdomain arch" >> /etc/hosts
systemctl enable dhcpcd@enp3s0.service

echo_info "Setup Root user"
passwd

echo_info "Setup pacman"
pacman -Sy reflector
reflector --verbose -l 5 --sort rate --save /etc/pacman.d/mirrorlist
echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
echo "Server = https://www.archlinux.org/mirrorlist/" >> /etc/pacman.d/mirrorlist

echo_info "Bootloader"
pacman -Sy intel-ucode
pacman -Syd dialog wpa_supplicant
sed -i "s/HOOKS/#HOOKS/g" /etc/mkinitcpio.conf
echo "HOOKS=(base udev autodetect keyboard keymap modconf block encrypt lvm2 filesystems fsck)" >> /etc/mkinitcpio.conf
mkinitcpio -p linux
bootctl --path=/boot install
echo "default arch" > /boot/loader/loader.conf
echo "editor 0" >> /boot/loader/loader.con
echo "title Arch Linux" > /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /intel-ucode.img" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf
export PART_ID=$(blkid -o value -s UUID ${NVME}2)
echo "options cryptdevice=UUID=${PART_ID}:nvme_group root=/dev/mapper/nvme_group-root quiet rw" >> /boot/loader/entries/arch.conf

echo_info "Prepare reboot"
exit
