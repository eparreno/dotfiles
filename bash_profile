# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# git autocompletion
if [[ -s "/usr/local/Cellar/git/1.7.3.2/etc/bash_completion.d/git-completion.bash" ]]; then
source "/usr/local/Cellar/git/1.7.3.2/etc/bash_completion.d/git-completion.bash"
fi

# iTerm2 tab name
#export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'