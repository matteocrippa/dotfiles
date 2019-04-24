#!/bin/bash

. distro.sh
. packages.sh
. helpers.sh

echo_info "Installing lenovo packages..."
_install lenovo
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo systemctl enable lenovo_fix
sudo systemctl start lenovo_fix

# Install packages in the official repositories
echo_info "Installing core packages..."
_install core

_symlink
