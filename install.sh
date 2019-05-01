#!/bin/bash

. distro.sh
. packages.sh
. helpers.sh

echo_info "Install Yay"
sudo pacman -Sy yay

echo_info "Installing lenovo packages"
yay -Sy lenovo-throttling-fix-git
sudo systemctl enable lenovo_fix
sudo systemctl start lenovo_fix

echo_info "Enable disk trimming"
sudo systemctl enable fstrim.timer

# Install packages in the official repositories
echo_info "Installing core packages..."
_install core

echo_info "Force update all the system"
sudo pacman -Syyu
