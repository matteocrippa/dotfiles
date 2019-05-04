#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Installing zsh-autosuggestions, zsh-completions..."
_install zsh-completions
_install zsh-autosuggestions

echo_info "Installing Spaceship"
git clone https://aur.archlinux.org/spaceship-prompt-git.git /tmp/spaceship-prompt-git
cd /tmp/spaceship-prompt-git
makepkg -si

echo "autoload -U promptinit; promptinit" >> ~/.zshrc
echo "prompt spaceship" >> ~/.zshrc

echo "alias vi=nvim" >> ~/.zshrc

echo_done "ZSH configuration!"
