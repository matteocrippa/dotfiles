#!/bin/bash
git clone git@github.com:foxlet/macOS-Simple-KVM.git ~/Vm/macOS
cd ~/Vm/macOS
./jumpstart.sh
qemu-img create -f qcow2 MyDisk.qcow2 64G
echo "-drive id=SystemDisk,if=none,file=MyDisk.qcow2 \\" >> basic.sh
echo "-device ide-hd,bus=sata.4,drive=SystemDisk \\" >> basic.sh
./basic.sh
./make.sh --add
