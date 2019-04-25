#!/bin/bash

. distro.sh
. helpers.sh

echo_info "Bootloader"
pacman -Sy sed intel-ucode
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
