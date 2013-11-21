if [[ -n $BASH ]]; then
  shopt -s histappend
  HISTIGNORE='ls:bg:fg:history'
  HISTFILESIZE=5000
  HISTSIZE=5000
  PROMPT_COMMAND='history -a'
elif [[ -n $ZSH_VERSION ]]; then
  HISTFILE=~/.zsh_history
  HISTSIZE=5000
  SAVEHIST=5000
  HISTDUP=erase
  setopt  inc_append_history  # Immediately append to the history file
fi
