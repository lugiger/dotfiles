#!/bin/bash

echo "Initializing submodule(s)"
git submodule update --init --recursive

echo "Installing dotfiles"

source install/install_apps.sh
cd ~/.dotfiles
source install/link.sh

echo "Configuring zsh as default shell"
chsh -s $(which zsh)

echo "Done."
