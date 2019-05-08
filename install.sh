#!/bin/bash

. distro.sh
. packages.sh
. helpers.sh

echo_info "Force update all the system"
yay -Syyu

echo_info "Install Yay"
sudo pacman -Sy yay

# Install packages in the official repositories
echo_info "Installing core packages..."
_install core

echo_info "Installing lenovo packages"
yay -Sy lenovo-throttling-fix-git
sudo systemctl enable lenovo_fix
sudo systemctl start lenovo_fix

echo_info "Enable disk trimming"
sudo systemctl enable fstrim.timer

echo_info "Enable bluetooth"
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

echo_info "Active remote ntp time"
sudo systemctl enable systemd-timesyncd
sudo systemctl start systemd-timesyncd

echo_info "Activate libvirtual"
sudo systemctl enable libvirtd
sudo systemctl start libvirtd

echo_info "Activate laptop-mode"
sudo cp tlp /etc/default/tlp
sudo systemctl enable tlp
sudo systemctl enable tlp-slep.service
sudo systemctl enable thermald

# Install displaylink
echo_info "Installing displaylink..."
yay -Sy linux50-headers evdi displaylink
sudo systemctl enable displaylink.service
sudo cp ./displaylink/20-evdidevice.conf /usr/share/X11/xorg.conf.d/20-evdidevice.conf

# Setup extra keys
sudo echo "evdev:name:ThinkPad Extra Buttons:dmi:bvn*:bvr*:bd*:svnLENOVO*:pn*" > /etc/udev/hwdb.d/90-thinkpad-keyboard.hwdb
sudo echo "KEYBOARD_KEY_45=prog1" >> /etc/udev/hwdb.d/90-thinkpad-keyboard.hwdb
sudo echo "KEYBOARD_KEY_49=prog2" >> /etc/udev/hwdb.d/90-thinkpad-keyboard.hwdb
sudo udevadm hwdb --update
sudo udevadm trigger --sysname-match="event*"
# "XF86Launch2" (KEY_KEYBOARD) and "XF86Launch1" (KEY_FAVORITES)

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
cd ~
