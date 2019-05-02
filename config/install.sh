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
mkdir -p ~/.fonts ~/Downloads/fonts

curl https://noto-website-2.storage.googleapis.com/pkgs/NotoColorEmoji-unhinted.zip \
  -o ~/Downloads/fonts/emoji-font.zip

wget -O ~/Downloads/fonts/Hack.zip \
  https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/Hack.zip

wget -O ~/Downloads/fonts/fontawesome.zip \
  https://use.fontawesome.com/releases/v5.7.1/fontawesome-free-5.7.1-desktop.zip

sudo cp ~/.dotfiles/config/50-noto-color-emoji.conf /etc/fonts/conf.d/

yay -Sy nerd-fonts-complete
