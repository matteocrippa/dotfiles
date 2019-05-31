#!/bin/bash
git clone git@github.com:matteocrippa/macOS-Simple-KVM.git ~/Vm/macOS
cd ~/Vm/macOS
./install.sh
./jumpstart.sh
qemu-img create -f qcow2 MyDisk.qcow2 64G
./start.sh
