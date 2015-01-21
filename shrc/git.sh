alias g="git"
alias gd="git diff"
alias gb="git branch"
alias gg="git grep --break --heading --line-number"
alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gaa="git add --all"
alias gci="git commit -m"
alias gst="git status -sb"
alias gms="git checkout master"
alias gphm="git push heroku master"
alias gpsm="git push staging master"
alias gum="git fetch && git reset --hard origin/master"

if [[ -n $BASH ]]; then
  if [[ -s "/usr/local/etc/bash_completion.d/git-completion.bash" ]]; then
    source "/usr/local/etc/bash_completion.d/git-completion.bash"
  fi
fi
