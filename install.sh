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

# Install displaylink
echo_info "Installing displaylink..."
yay -Sy displaylink
sudo systemctl enable displaylink.service
sudo cp ./displaylink/20-evdidevice.conf /usr/share/X11/xorg.conf.d/20-evdidevice.conf

# Install packages in the official repositories
echo_info "Installing core packages..."
_install core

echo_info "Force update all the system"
sudo pacman -Syyu

echo_info "Force remove unused apps"
yay -Rs palemoon-bin

echo_info "Prepare directories"
mkdir -p ~/Work/Repositories/
mkdir -p ~/Work/Material/
mkdir -p ~/GDrive

echo_info "Setup Google Drive"
export GDRIVE_DIR="GDrive"
cd ~/${GDRIVE_DIR}
grive -a
systemctl --user enable grive-timer@$(systemd-escape ${GDRIVE_DIR}).timer
systemctl --user start grive-timer@$(systemd-escape ${GDRIVE_DIR}).timer
systemctl --user enable grive-changes@$(systemd-escape ${GDRIVE_DIR}).service
systemctl --user start grive-changes@$(systemd-escape ${GDRIVE_DIR}).service
