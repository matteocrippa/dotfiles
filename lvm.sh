#!/bin/bash

. distro.sh

echo "LVM"

# NvMe
cryptsetup luksFormat /dev/sda2
cryptsetup open --type luks /dev/sda2 foo
pvcreate /dev/mapper/foo
vgcreate foo_group /dev/mapper/foo
lvcreate -L32G  foo_group -n swap
lvcreate -l 100%FREE foo_group -n root

# SSD
cryptsetup luksFormat /dev/sdb1
cryptsetup open --type luks /dev/sdb1 bar
pvcreate /dev/mapper/bar
vgcreate bar_group /dev/mapper/bar
lvcreate -l 100%FREE bar_group -n home
