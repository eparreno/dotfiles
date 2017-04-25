# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

red='\e[0;31m'
green='\e[0;32m'
yellow='\e[0;33m'
blue='\e[0;34m'
magenta='\e[0;35m'
cyan='\e[0;36m'
white='\e[0;37m'
bold='\033[1m'

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export HISTCONTROL=ignoredups
export EDITOR=vim

PATH="$HOME/.bin:$PATH"
export PATH

# bash_completion for MAC OS X
if [ -f $(brew --prefix 2> /dev/null)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# bash_completion for Debian
if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

# mojombo http://gist.github.com/180587
function psg {
  ps wwwaux | egrep "($1|%CPU)" | grep -v grep
}

ruby_version() {
  ruby -e 'print RUBY_VERSION'
}

git_prompt() {
  local git_branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

  if [[ -n "$git_branch" ]]; then
    if [[ -n $(git status --porcelain 2> /dev/null) ]]; then
      git_color="$red"
    else
      git_color="$green"
    fi
  fi

  echo "$git_color$git_branch"
}

# http://vvv.tobiassjosten.net/bash/dynamic-prompt-with-git-and-ansi-colors/
PROMPT_COMMAND='PS1="\u@\h ${cyan}\w ${yellow}$(ruby_version) $(git_prompt)${white}\n% "'

alias l="ls -lh"
alias la="ls -lah"
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias du='du -kh'
alias tlf="tail -f"
alias grep='grep --color=auto'
alias gst='git status'
alias gg="git grep --break --heading --line-number"
alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

eval "$(rbenv init - --no-rehash)"

# release Ctrl-S to be used by Vim
stty -ixon -ixoff
