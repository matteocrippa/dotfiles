#!/bin/bash

. distro.sh
. packages.sh
. helpers.sh

echo_info "Get spells"
git clone https://github.com/matteocrippa/spells  ~/.spells

echo_info "Symlink dotfiles..."
_symlink
