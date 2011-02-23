# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# bash_completion
if [[ -s "/usr/local/Cellar/git/1.7.3.2/etc/bash_completion.d/git-completion.bash" ]]; then
source "/usr/local/Cellar/git/1.7.3.2/etc/bash_completion.d/git-completion.bash"
fi

# use vim as an editor
export EDITOR=vim

#export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'
export NODE_PATH="/usr/local/lib/node"
export VIMRC="~/.vimrc"
export PATH="/usr/local/share/npm/bin:$PATH"

## aliases
# system
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias du='du -kh'     
alias df='df -kTh'
alias tlf="tail -f"
alias ls="ls -l"
#rails aliases
alias migrate="rake db:migrate db:test:prepare"
alias remigrate="rake db:migrate && rake db:migrate:redo && rake db:schema:dump db:test:prepare"
alias rspec="bundle exec rspec"
alias bi="bundle install"
alias bu="bundle update"
alias be="bundle exec"
#misc
alias g="git"

