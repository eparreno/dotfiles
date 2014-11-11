#!/usr/bin/env bash

# This script is based on thoughtbot laptop script
# https://github.com/thoughtbot/laptop
#
# WARNING: before use it, please check what the script does

fancy_echo() {
  printf "\n%b\n" "$1"
}

append_to_zshrc() {
  local text="$1" zshrc
  local skip_new_line="$2"

  if [[ -w "$HOME/.zshrc.local" ]]; then
    zshrc="$HOME/.zshrc.local"
  else
    zshrc="$HOME/.zshrc"
  fi

  if ! grep -Fqs "$text" "$zshrc"; then
    if (( skip_new_line )); then
      printf "%s\n" "$text" >> "$zshrc"
    else
      printf "\n%s\n" "$text" >> "$zshrc"
    fi
  fi
}

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

if [[ ! -d "$HOME/.bin/" ]]; then
  mkdir "$HOME/.bin"
fi

if [[ ! -f "$HOME/.zshrc" ]]; then
  touch "$HOME/.zshrc"
fi

append_to_zshrc 'export PATH="$HOME/.bin:$PATH"'

if [[ "$SHELL" != */zsh ]]; then
  fancy_echo "Changing your shell to zsh ..."
    chsh -s $(which zsh)
fi

brew_install_or_upgrade() {
  if brew_is_installed "$1"; then
    if brew_is_upgradable "$1"; then
      brew upgrade "$@"
    fi
  else
    brew install "$@"
  fi
}

brew_is_installed() {
  local name="$(brew_expand_alias "$1")"

  brew list -1 | grep -Fqx "$name"
}

brew_is_upgradable() {
  local name="$(brew_expand_alias "$1")"

  brew outdated --quiet "$name" >/dev/null
  [[ $? -ne 0 ]]
}

brew_expand_alias() {
  brew info "$1" 2>/dev/null | head -1 | awk '{gsub(/:/, ""); print $1}'
}

brew_launchctl_restart() {
  local name="$(brew_expand_alias "$1")"
  local domain="homebrew.mxcl.$name"
  local plist="$domain.plist"

  mkdir -p "$HOME/Library/LaunchAgents"
  ln -sfv "/usr/local/opt/$name/$plist" "$HOME/Library/LaunchAgents"

  if launchctl list | grep -q "$domain"; then
    launchctl unload "$HOME/Library/LaunchAgents/$plist" >/dev/null
  fi
  launchctl load "$HOME/Library/LaunchAgents/$plist" >/dev/null
}

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew, a good OS X package manager ..."
    ruby <(curl -fsS https://raw.githubusercontent.com/Homebrew/install/master/install)

    append_to_zshrc '# recommended by brew doctor'
    append_to_zshrc 'export PATH="/usr/local/bin:$PATH"' 1
    export PATH="/usr/local/bin:$PATH"
else
  fancy_echo "Homebrew already installed. Skipping ..."
fi

fancy_echo "Updating Homebrew formulas ..."
  brew update

fancy_echo "Installing vim from Homebrew to get the latest version ..."
  brew_install_or_upgrade 'vim'

fancy_echo "Installing tmux, to save project state and switch between projects ..."
  brew_install_or_upgrade 'tmux'

fancy_echo "Installing reattach-to-user-namespace, for copy-paste and RubyMotion compatibility with tmux ..."
  brew_install_or_upgrade 'reattach-to-user-namespace'

fancy_echo "Installing GitHub CLI client ..."
  brew_install_or_upgrade 'gh'

fancy_echo "Installing ImageMagick, to crop and resize images ..."
  brew_install_or_upgrade 'imagemagick'

fancy_echo "Installing QT, used by Capybara Webkit for headless Javascript integration testing ..."
  brew_install_or_upgrade 'qt'

#fancy_echo "Installing Postgres, a good open source relational database ..."
#  brew_install_or_upgrade 'postgres'

#fancy_echo "Installing Redis, a good key-value database ..."
#  brew_install_or_upgrade 'redis'

#fancy_echo "Installing The Silver Searcher (better than ack or grep) to search the contents of files ..."
#  brew_install_or_upgrade 'the_silver_searcher'

#fancy_echo "Installing ctags, to index files for vim tab completion of methods, classes, variables ..."
#  brew_install_or_upgrade 'ctags'

#fancy_echo "Installing watch, to execute a program periodically and show the output ..."
#  brew_install_or_upgrade 'watch'

node_version="0.10"

#fancy_echo "Installing NVM, Node.js, and NPM, for running apps and installing JavaScript packages ..."
#  brew_install_or_upgrade 'nvm'

 # append_to_zshrc 'export PATH="$PATH:/usr/local/lib/node_modules"'
 # append_to_zshrc 'source $(brew --prefix nvm)/nvm.sh' 1

 # source $(brew --prefix nvm)/nvm.sh
 # nvm install "$node_version"

#  fancy_echo "Setting $node_version as the global default nodejs..."
#  nvm alias default "$node_version"

#fancy_echo "Starting Postgres ..."
#  brew_launchctl_restart postgresql

if [[ ! -d "$HOME/.rbenv" ]]; then
  fancy_echo "Installing rbenv, to change Ruby versions ..."
    git clone https://github.com/sstephenson/rbenv.git "$HOME/.rbenv"

    append_to_zshrc 'export PATH="$HOME/.rbenv/bin:$PATH"'
    append_to_zshrc 'eval "$(rbenv init - zsh --no-rehash)"' 1

    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init - zsh)"
fi

rehash_path="$HOME/.rbenv/plugins/rbenv-gem-rehash"

if [[ ! -d "$rehash_path" ]]; then
  fancy_echo "Installing rbenv-gem-rehash so the shell automatically picks up binaries after installing gems with binaries..."
    git clone https://github.com/sstephenson/rbenv-gem-rehash.git "$rehash_path"
fi

ruby_build_path="$HOME/.rbenv/plugins/ruby-build"

if [[ -d "$ruby_build_path" ]]; then
  fancy_echo "Updating to latest ruby-build..."
  cd "$ruby_build_path" && git pull && cd -
else
  fancy_echo "Installing ruby-build..."
  git clone https://github.com/sstephenson/ruby-build.git "$ruby_build_path"
fi

fancy_echo "Upgrading and linking OpenSSL ..."
  brew_install_or_upgrade 'openssl'
  brew unlink openssl && brew link openssl --force

ruby_version="$(curl -sSL http://ruby.thoughtbot.com/latest)"

fancy_echo "Installing Ruby $ruby_version ..."
  rbenv install -s "$ruby_version"

fancy_echo "Setting $ruby_version as global default Ruby ..."
  rbenv global "$ruby_version"
  rbenv local "$ruby_version"
  rbenv rehash

fancy_echo "Updating to latest Rubygems version ..."
  gem update --system

fancy_echo "Installing Bundler to install project-specific Ruby gems ..."
  gem install bundler --no-document

fancy_echo "Configuring Bundler for faster, parallel gem installation ..."
  number_of_cores=$(sysctl -n hw.ncpu)
  bundle config --global jobs $((number_of_cores - 1))

#fancy_echo "Installing Suspenders, thoughtbot's Rails template ..."
#  gem install suspenders --no-document

#fancy_echo "Installing Parity, shell commands for development, staging, and
#production parity ..."
#  gem install parity --no-document

fancy_echo "Installing Heroku CLI client ..."
  brew_install_or_upgrade 'heroku-toolbelt'

#fancy_echo "Installing the heroku-config plugin to pull config variables locally to be used as ENV variables ..."
  heroku plugins:install https://github.com/ddollar/heroku-config.git

fancy_echo "Installing foreman ..."
  curl -sLo /tmp/foreman.pkg http://assets.foreman.io/foreman/foreman.pkg && \
  sudo installer -pkg /tmp/foreman.pkg -tgt /

fancy_echo "Installing your personal additions from ~/.laptop.local ..."
  if [[ -f ~/.laptop.local ]]; then
    source ~/.laptop.local
  fi
