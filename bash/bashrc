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
export EDITOR=vim
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries

PATH="$HOME/.bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
# PATH="$HOME/.rbenv/bin:$PATH"
export PATH

set timeoutlen=1000 ttimeoutlen=0

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
PROMPT_COMMAND='PS1="[bash] \u@\h ${cyan}\w ${yellow}$(ruby_version) $(git_prompt)${white}\n% "'

# iTerm tab titles
precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}

alias l="ls -lh"
alias la="ls -lah"
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias du='du -kh'
alias df='df -kTh'
alias tlf="tail -f"
alias grep='grep --color=auto'
alias psg='ps aux | grep -v grep | grep'

alias e='vim'
alias t='tmux'
alias tls='tmux ls'
alias tat='tmux at'
alias fs='foreman start'

alias g="git status -sb"
alias gd="git diff"
alias gb="git branch"
alias gg="git grep --break --heading --line-number"
alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gaa="git add --all"
alias gci="git commit -m"
alias gms="git checkout master"
alias gphm="git push heroku master"
alias gpsm="git push staging master"
alias gum="git co master && git fetch && git reset --hard origin/master"
alias push='git push'

alias bi="bundle install"
alias bu="bundle update"
alias be="bundle exec"

alias dk="docker"
alias dkc="docker-compose"
alias dcop='docker-compose run --rm api bundle exec rubocop $1'
alias dspec='docker-compose run --rm api ./bin/rspec $1'
alias dcon='docker-compose run --rm api bundle exec rails c'

eval "$(rbenv init - --no-rehash)"
eval "$(direnv hook bash)"

# release Ctrl-S to be used by Vim
stty -ixon -ixoff
