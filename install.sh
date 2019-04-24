#!/bin/bash

. distro.sh
. packages.sh
. helpers.sh

echo_info "Installing lenovo packages..."
_install lenovo

# Install packages in the official repositories
echo_info "Installing core packages..."
_install core

# Install packages in the AUR
# echo_info "Installing aur packages..."
# _install aur

_symlink
