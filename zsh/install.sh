#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo "alias vi=nvim" >> ~/.zshrc

echo_done "ZSH configuration!"
