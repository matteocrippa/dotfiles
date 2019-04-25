#!/bin/bash

. distro.sh
. helpers.sh

echo_info "Prepare keyfile"
export PART_ID=$(blkid -o value -s UUID ${SSD}1)
sudo echo "ssd UUID=${PART_ID} /root/keyfile luks" >> /mnt/etc/crypttab

echo_info "Bootloader"
pacman -Sy sed intel-ucode
echo "default arch" > /boot/efi/loader/loader.conf
echo "editor 0" >> /boot/efi/loader/loader.con
echo "title Arch Linux" > /boot/efi/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/efi/loader/entries/arch.conf
echo "initrd /intel-ucode.img" >> /boot/efi/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/efi/loader/entries/arch.conf
export PART_ID=$(blkid -o value -s UUID ${NVME}2)
echo "options cryptdevice=UUID=${PART_ID}:nvme_group root=/dev/mapper/nvme_group-root quiet rw" >> /boot/efi/loader/entries/arch.conf

echo_info "Prepare reboot"
exit
