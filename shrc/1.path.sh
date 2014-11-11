PATH="/usr/local/sbin:$PATH"
PATH="/usr/local/share/npm/bin:$PATH"

# load rbenv
if [[ -s "$HOME/.rbenv" ]]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# load rvm
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
    source "$HOME/.rvm/scripts/rvm"
fi

PATH="$HOME/bin:$PATH"

export PATH
