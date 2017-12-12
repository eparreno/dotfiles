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
      git_color="%{$fg[red]%}"
    else
      git_color="%{$fg[green]%}"
    fi
  fi

  echo "$git_color$git_branch "
}

# iTerm tab titles
precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}

local user='%{$fg[white]%}%n%{$reset_color%}'
local host='%{$fg[white]%}%1m%{$reset_color%}'
local dir='%{$fg[cyan]%}%~%{$reset_color%}'
local ruby='%{$fg[yellow]%}$(ruby_version)%{$reset_color%}'
local git='$(git_prompt)%{$reset_color%}'
local arrow='%{$fg[green]%}➜%{$reset_color%}'

PROMPT=$(print "[zsh] $user@$host $dir $ruby $git\n\ %# ")

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
alias n='nvim'
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

alias migrate="bin/rake db:migrate && bin/rake db:migrate RAILS_ENV=test"
alias remigrate="bin/rake db:migrate && bin/rake db:rollback && bin/rake db:migrate"
alias bi="bundle install"
alias bu="bundle update"
alias be="bundle exec"

alias reload='source ~/.zshrc'

alias dk="docker"
alias dkc="docker-compose"
alias dcop='docker-compose run --rm api bundle exec rubocop $1'
alias dspec='docker-compose run --rm api ./bin/rspec $1'
alias dcon='docker-compose run --rm api bundle exec rails c'

PATH="$HOME/.bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
# PATH="$HOME/.rbenv/shims:$PATH"
# PATH="$HOME/.rbenv/bin:$PATH"
export PATH

# eval "$(rbenv init - zsh --no-rehash)"
eval "$(direnv hook zsh)"

if [ -f ~/.zshrc.local ]; then
  . ~/.zshrc.local
fi
