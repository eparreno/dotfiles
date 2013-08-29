export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

if [[ -n $ZSH_VERSION ]]; then
  # Find the option for using colors in ls, depending on the version: Linux or BSD
  ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
fi
