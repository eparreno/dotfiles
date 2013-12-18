alias g="git"
alias gaa="git add --all"
alias gci="git commit -m"
alias gst="git status -sb"
alias gd="git diff"
alias gg="git grep --break --heading --line-number"
alias gl="git log"
alias gl1="git log --oneline --decorate"
alias gl2="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gl3="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gpom="git push origin master"
alias gphm="git push heroku master"
alias gpsm="git push staging master"

if [[ -n $BASH ]]; then
  if [[ -s "/usr/local/etc/bash_completion.d/git-completion.bash" ]]; then
    source "/usr/local/etc/bash_completion.d/git-completion.bash"
  fi
fi
