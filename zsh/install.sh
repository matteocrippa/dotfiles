#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

yay -Sy zsh-theme-powerlevel10k-git 

rm ~/.zshrc
ln -sfT ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -sfT ~/.dotfiles/zsh/.zsh_aliases ~/.zsh_aliases
ln -sfT ~/.dotfiles/zsh/.zsh_purepower ~/.zsh_purepower

echo_done "ZSH configuration!"
