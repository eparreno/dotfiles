unset MAILCHECK

# default umask
umask 0022

# config colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

show_git_dirty() {
  local git_status=$(git status 2>&1 | tail -n1)
  [[ $git_status != "fatal: Not a git repository (or any of the parent directories): .git" ]] && [[ $git_status != "nothing to commit (working directory clean)" ]] && echo "!"
}

show_git_branch() {
  _branch="$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
  test -n "$_branch" && echo -e " $_branch"
}

# prompt with ruby version
ruby_version()
{
  echo "$(ruby -e 'print RUBY_VERSION')"
}

show_dev_info() {
  echo "($(ruby_version)$(show_git_branch)$(show_git_dirty))"
}

# bash_completion
if [[ -s "/usr/local/Cellar/git/1.7.6/etc/bash_completion.d/git-completion.bash" ]]; then
  source "/usr/local/Cellar/git/1.7.6/etc/bash_completion.d/git-completion.bash"
fi

# colors
Black='\e[0;30m'
Red='\e[0;31m'
LightRed='\e[1;31m'
Green='\e[0;32m'
LightGreen='\e[1;32m'
Yellow='\e[0;33m'
Blue='\e[0;34m'
Purple='\e[0;35m'
Cyan='\e[0;36m'
White='\e[0;37m'

# set the PS1 variable (prompt)
#export PS1="\w\[\e[0;33;49m\]\$(parse_git_branch)\[\e[0;0m\]$ "
#export PS1="\e[0;33m\w\$(show_git_branch)\[\e[0;0m\]$ "
#export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\] $(show_git_branch)$(show_git_dirty)\[\033[01;34m\] \$\[\033[00m\] '
PS1="\[$Yellow\]\u@\h \[$Cyan\]\w \[$Green\]\$(show_dev_info)\n\[$White\]➔\[$White\] "

# system aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias du='du -kh'
alias df='df -kTh'
alias tlf="tail -f"
alias l="ls -l"
alias la="ls -la"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias spec='./script/spec'
alias t='tmux'

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
alias glb="git log --oneline --decorate"
alias gaa="git add --all"
alias gci="git ci -m"
alias gst="git st -sb"
alias gpom="git push origin master"
alias gphm="git push heroku master"
alias gpsm="git push staging master"
alias gppm="git push production master"

# environment variables
export VIMRC="~/.vimrc"
export CLICOLOR=1
export TERM=xterm-256color
export EDITOR="vim"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# xterm tab title
# export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
  PS1="\[\e]0;@\h: \w\a\]$PS1"
  ;;
*)
  ;;
esac

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
