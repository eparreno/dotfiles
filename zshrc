autoload -U compinit && compinit
autoload -U colors && colors

# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
HISTDUP=erase
setopt inc_append_history  # Immediately append to the history file
setopt prompt_subst

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export GREP_COLOR='1;32'
export EDITOR="vim"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

bindkey -e

# No flow control. Let me use Ctrl+s in Vim
stty -ixon -ixoff 2>/dev/null

# Resume vim using ctrl+z instead of fg
foreground-vi() {
  fg %vi
}
zle -N foreground-vi
bindkey '^Z' foreground-vi

### Prompt ###
ruby_version() {
  echo -n "$(ruby -e 'print RUBY_VERSION')"
}

git_prompt() {
  local git_branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

  if [[ -n "$git_branch" ]]; then
    if [[ -n $(git status --porcelain 2> /dev/null) ]]; then
      git_color="%{$fg[yellow]%}"
    else
      git_color="%{$fg[green]%}"
    fi
  fi

  echo "$git_color$git_branch "
}

local user='%{$fg[white]%}%n%{$reset_color%}'
local host='%{$fg[white]%}%1m%{$reset_color%}'
local dir='%{$fg[cyan]%}%~%{$reset_color%}'
local ruby='%{$fg[red]%}$(ruby_version)%{$reset_color%}'
local git='$(git_prompt)%{$reset_color%}'
local prompt='%{$fg[green]%}⮑ %{$reset_color%}'

PROMPT=$(print "\n[zsh] $dir $ruby $git\n $prompt ")

precmd() {
  # iTerm tab titles. Sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}

### Alias ###
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
# List local branches in a nice format
alias gbl="git for-each-ref --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(color:cyan)%(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
# Delete all local branches except master and develop
alias gbld="git for-each-ref --format '%(refname:short)' refs/heads | grep -v 'master\|develop' | xargs git branch -D"
alias gg="git grep --break --heading --line-number"
alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gaa="git add --all"
alias gci="git commit -m"
alias gms="git checkout master"
alias gphm="git push heroku master"
alias gpsm="git push staging master"
alias gum="git co master && git fetch && git reset --hard origin/master"
alias gumain="git co main && git fetch && git reset --hard origin/main"
alias gud="git co develop && git fetch && git reset --hard origin/develop"
alias push='git push'

alias migrate="bin/rake db:migrate && bin/rake db:migrate RAILS_ENV=test"
alias remigrate="bin/rake db:migrate && bin/rake db:rollback && bin/rake db:migrate"
alias bi="bundle install"
alias bu="bundle update"
alias be="bundle exec"

alias reload='source ~/.zshrc'

alias dk="docker"
alias dkc="docker compose"

# LTE Environment
alias lte-proxy="~/stuart/load-test/infra/tooling/lte-proxy.sh"
#
PATH="$HOME/.rbenv/bin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="~/.bin:$PATH"
PATH="/usr/local/sbin:$PATH"
export PATH

eval "$(rbenv init - zsh)"
eval "$(direnv hook zsh)"

# Local configuration
if [ -f ~/.zshrc.local ]; then
  . ~/.zshrc.local
fi
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
