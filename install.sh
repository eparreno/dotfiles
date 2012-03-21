#!/usr/bin/env bash

# A script to install these dotfiles onto a new machine.
#
# Usage:
#  bash < <( curl http://github.com/eparreno/dotfiles/raw/master/install.sh )

DOTFILE_PATH="${DOTFILE_PATH:-$HOME/.dotfiles}"

if [[ -d "$HOME/.dotfiles" ]]; then
    pushd $DOTFILE_PATH
    git pull origin master
else
    git clone http://github.com/eparreno/dotfiles.git $DOTFILE_PATH
    pushd $DOTFILE_PATH
fi

read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1

if [[ $REPLY =~ ^[Yy]$ ]]; then
  /usr/bin/env ruby install.rb
fi
