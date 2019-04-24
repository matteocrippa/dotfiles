#!/bin/bash

. distro.sh

echo "LVM"

sudo cryptsetup luksFormat /dev/sda2
sudo cryptsetup open --type luks /dev/sda2 foo
sudo pvcreate /dev/mapper/foo
sudo vgcreate foo_group /dev/mapper/foo
sudo lvcreate -L32G  foo_group -n swap
sudo lvcreate -l 100%FREE foo_group -n root

sudo cryptsetup luksFormat /dev/sdb1
sudo cryptsetup open --type luks /dev/sdb1 bar
sudo pvcreate /dev/mapper/bar
sudo vgcreate bar_group /dev/mapper/bar
sudo lvcreate -l 100%FREE bar_group -n home
