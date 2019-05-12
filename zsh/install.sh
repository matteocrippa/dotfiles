#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo "alias vi=nvim" >> ~/.zshrc
echo '[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases' >> ~/.zshrc

ln -sfT ~/.dotfiles/zsh/.zsh_aliases ~/.zsh_aliases

echo_done "ZSH configuration!"
