if [ -n "$ZSH_VERSION" ]; then
  # Resume vim after using ctrl+z again instead of fg
  foreground-vi() {
    fg %vi
  }
  zle -N foreground-vi
  bindkey '^Z' foreground-vi
fi
