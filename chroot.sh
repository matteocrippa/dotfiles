#!/bin/bash

. distro.sh
. helpers.sh

echo_info "Prepare keyfile"
export PART_ID=$(blkid -o value -s UUID ${SSD}1)
sudo echo "ssd UUID=${PART_ID} /root/keyfile luks" >> /etc/crypttab

echo_info "Bootloader"
mkinitcpio -p linux
bootctl --path=/boot install

#touch /boot/loader/entries/arch.conf
#echo "title Arch Linux" >> /boot/loader/entries/arch.conf
#echo "linux /vmlinuz-5.1-x86_64" >> /boot/loader/entries/arch.conf
#echo "initrd /intel-ucode.img" >> /boot/loader/entries/arch.conf
#echo "initrd /initramfs5.1-x86_64.img" >> /boot/loader/entries/arch.conf
#export PART_ID=$(blkid -o value -s UUID ${NVME}2)
#echo "options cryptdevice=UUID=${PART_ID}:nvme_group root=/dev/mapper/nvme_group-root quiet rw" >> /boot/loader/entries/arch.conf

echo_info "Edit /boot/loader/entries/arch.conf according proper files"
exit
