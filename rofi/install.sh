#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Installing rofi..."
_install rofi

echo_info "Symlink rofi config"
mkdir -p ~/.config/rofi
ln -sfT ~/.dotfiles/rofi/config ~/.config/rofi/config
ln -sfT ~/.dotfiles/rofi/aliases.sh ~/.config/rofi/aliases.sh

echo_done "Rofi configuration!"
