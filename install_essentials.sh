#!/bin/bash

# Installs Hombrew and some essential packages

install() {
  if ! command -v "$1" &>/dev/null; then
    echo "$1 NOT INSTALLED"
    return 0
  else
    echo -e " ✅ $1 already installed"
  fi
}


if ! command -v "brew" &>/dev/null; then
  echo "Installing Hombrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo -e ' ✅ Hombrew already installed'
fi

install "git"
install "nvim" # The Editor
install "lua" # for nvim
install "tree-sitter" # Needed for nvim
install "tmux"
install "bat" # a better alternative to cat
install "fzf" # fuzzy finder
