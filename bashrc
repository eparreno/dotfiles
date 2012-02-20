unset MAILCHECK

# default umask
umask 0022

# config colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

show_rvm_version() {
  local gemset=$(echo $GEM_HOME | awk -F'@' '{print $2}')
  [ "$gemset" != "" ] && gemset="@$gemset"
  local version=$(echo $MY_RUBY_HOME | awk -F'-' '{print $2}')
  [ "$version" != "" ] && version="$version"
  local full="$version$gemset"
  [ "$full" != "" ] && echo "$full"
}

show_git_dirty() {
  local git_status=$(git status 2>&1 | tail -n1)
  [[ $git_status != "fatal: Not a git repository (or any of the parent directories): .git" ]] && [[ $git_status != "nothing to commit (working directory clean)" ]] && echo "*"
}

show_git_branch() {
  _branch="$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
  test -n "$_branch" && echo -e " $_branch"
}

show_dev_info() {
  echo "($(show_rvm_version)$(show_git_branch)$(show_git_dirty))"
}

# bash_completion
if [[ -s "/usr/local/Cellar/git/1.7.6/etc/bash_completion.d/git-completion.bash" ]]; then
  source "/usr/local/Cellar/git/1.7.6/etc/bash_completion.d/git-completion.bash"
fi

# rvm
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  source "$HOME/.rvm/scripts/rvm"
fi

# colors
Black='\e[0;30m'
Red='\e[0;31m'
Green='\e[0;32m'
Yellow='\e[0;33m'
Blue='\e[0;34m'
Purple='\e[0;35m'
Cyan='\e[0;36m'
White='\e[0;37m'

# set the PS1 variable (prompt)
#export PS1="\w\[\e[0;33;49m\]\$(parse_git_branch)\[\e[0;0m\]$ "
#export PS1="\e[0;33m\w\$(show_git_branch)\[\e[0;0m\]$ "
#export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\] $(show_git_branch)$(show_git_dirty)\[\033[01;34m\] \$\[\033[00m\] '
PS1="\[$Cyan\]\w \[$Yellow\]\$(show_dev_info)\[$White\]$ "

# system aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias du='du -kh'
alias df='df -kTh'
alias tlf="tail -f"
alias ll="ls -l"
alias la="ls -la"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# rails aliases
alias migrate="bundle exec rake db:migrate db:test:prepare"
alias remigrate="bundle exec rake db:migrate db:migrate:redo db:test:prepare"
alias rspec="time bundle exec rspec"
alias bi="bundle install"
alias bu="bundle update"
alias be="bundle exec"

# git aliases
alias g="git"
alias gl="git log"
alias gaa="git add --all"
alias gci="git ci -m"
alias gst="git st"
alias gpsm="git push staging master"
alias gppm="git push production master"
alias gphm="git push heroku master"
alias gpom="git push origin master"

# environment variables
export VIMRC="~/.vimrc"
export CLICOLOR=1
export TERM=xterm-color
export EDITOR="vim"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# iterm2 tab title
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'
