if [[ $(uname) == 'linux' ]]; then
  alias l="ls -l --color"
  alias la="ls -la --color"
else
  alias l="ls -lh"
  alias la="ls -lah"
fi
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias du='du -kh'
alias df='df -kTh'
alias tlf="tail -f"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias t='tmux'

