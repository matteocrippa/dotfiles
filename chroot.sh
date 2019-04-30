#!/bin/bash

. distro.sh
. helpers.sh

echo_info "Prepare keyfile"
sudo mv /keyfile /root/keyfile
export PART_ID=$(blkid -o value -s UUID ${SSD}1)
sudo echo "ssd UUID=${PART_ID} /root/keyfile luks" >> /etc/crypttab

touch /boot/loader/entries/manjaro.conf
echo "title Arch Linux" >> /boot/loader/entries/manjaro.conf
echo "linux /vmlinuz-5.1-x86_64" >> /boot/loader/entries/manjaro.conf
echo "initrd /intel-ucode.img" >> /boot/loader/entries/manjaro.conf
echo "initrd /initramfs-5.1-x86_64.img" >> /boot/loader/entries/manjaro.conf
export PART_ID=$(blkid -o value -s UUID ${NVME}p2)
echo "options cryptdevice=UUID=${PART_ID}:nvme_group root=/dev/mapper/nvme_group-root quiet rw" >> /boot/loader/entries/manjaro.conf

echo "default manjaro" >> /boot/loader/loader.conf

echo_info "Edit /boot/loader/loader.conf"
exit
