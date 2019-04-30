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
sudo systemctl enable lenovo_fix

# Install packages in the official repositories
echo_info "Installing core packages..."
_install core

echo_info "Symlink dotfiles..."
_symlink

echo_info "Force update all the system"
sudo pacman -Syyu

echo_info "Install Pritunl OpenVPN"
sudo tee -a /etc/pacman.conf << EOF
  [pritunl]
  Server = https://repo.pritunl.com/stable/pacman
EOF

sudo pacman-key --keyserver hkp://keyserver.ubuntu.com -r 7568D9BB55FF9E5287D586017AE645C0CF8E292A
sudo pacman-key --lsign-key 7568D9BB55FF9E5287D586017AE645C0CF8E292A
sudo pacman -Sy
sudo pacman -S pritunl-client-electron
sudo pacman -S pritunl-client-electron-numix-theme
