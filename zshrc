unset MAILCHECK

umask 0022

HISTFILE=~/.zsh_history

autoload -U compinit
compinit -i
autoload colors; colors;

setopt prompt_subst

for file in ~/.shrc/*.sh; do
  source "$file"
done

if [ -f ~/.zshrc.local ]; then
  . ~/.zshrc.local
fi
