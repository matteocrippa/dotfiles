#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Symling .profile..."
ln -sfT ~/.dotfiles/config/profile ~/.profile

echo_info "Symlink libinput..."
ls -sfT ~/.dotfiles/config/libinput-getstures.conf ~/.config/libinput-gestures.conf

echo_info "Downloading fonts..."
wget -O ~/Downloads/fonts/fontawesome.zip \
  https://use.fontawesome.com/releases/v5.7.1/fontawesome-free-5.7.1-desktop.zip

yay -Sy nerd-fonts-complete
