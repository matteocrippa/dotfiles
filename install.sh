#!/bin/bash

. distro.sh
. packages.sh
. helpers.sh

echo_info "Installing lenovo packages..."
_install lenovo

# Install packages in the official repositories
echo_info "Installing core packages..."
_install core

_symlink
