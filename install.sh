#!/bin/bash

. distro.sh
. packages.sh
. helpers.sh

echo_info "Get spells"
git clone https://github.com/matteocrippa/spells  ~/.spells

echo_info "Installing lenovo packages..."
_install lenovo
sudo systemctl enable lenovo_fix
sudo systemctl start lenovo_fix
sudo systemctl enable fstrim.timer

# Install packages in the official repositories
echo_info "Installing core packages..."
_install core

echo_info "Symlink dotfiles..."
_symlink

echo_info "Force update all the system"
sudo pacman -Syyu
