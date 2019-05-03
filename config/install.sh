#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Symling .profile..."
ln -sfT ~/.dotfiles/config/profile ~/.profile

echo_info "Enable gestures..."
yay -Sy libinput-gestures
sudo gpasswd -a $USER input
ln -sfT ~/.dotfiles/config/libinput-gestures.conf ~/.config/libinput-gestures.conf

yay -Sy nerd-fonts-complete
yay -Sy ttf-font-awesome
yay -Sy noto-fonts-emoji
