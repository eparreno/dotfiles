alias g="git"
alias gl="git log"
alias gd="git diff"
alias gg="git grep -n"
alias glb="git log --oneline --decorate"
alias gaa="git add --all"
alias gci="git ci -m"
alias gst="git st -s"
alias gpom="git push origin master"
alias gphm="git push heroku master"
alias gpsm="git push staging master"

if [[ -n $BASH ]]; then
  if [[ -s "/usr/local/etc/bash_completion.d/git-completion.bash" ]]; then
    source "/usr/local/etc/bash_completion.d/git-completion.bash"
  fi
fi
