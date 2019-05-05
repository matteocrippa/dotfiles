#!/bin/bash
yay -Sy base-devel qemu uml_utilities virt-manager dmg2img
cd ~
git clone git://github.com/kholia/OSX-KVM
cd OSX-KVM
./fetch-macOS.py
dmg2img BaseSystem.dmg BaseSystem.img
qemu-img create -f qcow2 mac_hdd_ng.img 64G
sed -i "s/CHANGEME/$USER/g" macOS-libvirt-NG.xml
virsh --connect qemu:///system define macOS-libvirt-NG.xml
