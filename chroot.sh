#!/bin/bash

. distro.sh
. helpers.sh

echo_info "Prepare keyfile"
export PART_ID=$(blkid -o value -s UUID ${SSD}1)
sudo echo "ssd UUID=${PART_ID} /root/keyfile luks" >> /etc/crypttab

echo_info "Bootloader"
mkdir /boot/loader
mkdir /boot/loader/entries
echo "default arch" > /boot/loader/loader.conf
echo "editor 0" >> /boot/loader/loader.conf
echo "title Arch Linux" > /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /intel-ucode.img" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf
export PART_ID=$(blkid -o value -s UUID ${NVME}2)
echo "options cryptdevice=UUID=${PART_ID}:nvme_group root=/dev/mapper/nvme_group-root quiet rw" >> /boot/loader/entries/arch.conf

echo_info "Edit /boot/loader/entries/arch.conf according proper files"
exit
