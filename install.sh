#!/usr/bin/env bash

# A script to install these dotfiles onto a new machine.
#
# Usage:
#  bash < <( curl https://raw.github.com/eparreno/dotfiles/master/install.sh )

read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) "
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing...."
else
    echo 'Aborted.'
    exit 1
fi

DOTFILE_PATH="${DOTFILE_PATH:-$HOME/.dotfiles}"

if [[ -d "$HOME/.dotfiles" ]]; then
    pushd $DOTFILE_PATH
    git pull origin master
else
    git clone http://github.com/eparreno/dotfiles.git $DOTFILE_PATH
    pushd $DOTFILE_PATH
fi

/usr/bin/env ruby install.rb

popd
source "$HOME/.bashrc"
echo "Done!"
