#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

mv ~/.Xresources ~/.Xresources.bak
ln -sfT ~/.dotfiles/x/.Xresources ~/.Xresources

echo_done "Xresources configuration!"
