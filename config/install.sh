#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Symling .profile..."
ln -sfT ~/.dotfiles/config/profile ~/.profile

echo_info "Symlink libinput..."
ln -sfT ~/.dotfiles/config/libinput-getstures.conf ~/.config/libinput-gestures.conf

yay -Sy nerd-fonts-complete
yay -Sy ttf-font-awesome
