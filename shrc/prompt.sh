show_git_branch() {
  local ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo -n "${ref#refs/heads/} "
  fi
}

show_git_status() {
  [[ -n $(git status --porcelain 2> /dev/null) ]] && echo -n "✘ "
}

ruby_version() {
  echo -n "$(ruby -e 'print RUBY_VERSION')"
}

if [[ -n $BASH ]]; then
  prompt() {
    local red='\e[0;31m'
    local green='\e[0;32m'
    local yellow='\e[0;33m'
    local blue='\e[0;34m'
    local magenta='\e[0;35m'
    local cyan='\e[0;36m'
    local white='\e[0;37m'
    local bold='\033[1m'
    local underline='\033[4m'

    local user="\[$white\]\u\[$white\]"
    local host="\[$white\]\h\[$white\]"
    local dir="\[$cyan\]\w\[$white\]"
    local ruby="\[$yellow\]\$(ruby_version)\[$white\]"
    local git="\[$yellow\]\$(show_git_branch)\[$red\]\$(show_git_status)\[$white\]"

    echo "[$user@$host] $dir $ruby $git$ "
  }

  PS1=$(prompt)
elif [[ -n $ZSH_VERSION ]]; then
  local user='%{$fg[white]%}%n%{$reset_color%}'
  local host='%{$fg[white]%}%1m%{$reset_color%}'
  local dir='%{$fg[cyan]%}%~%{$reset_color%}'
  local ruby='%{$fg[yellow]%}$(ruby_version)%{$reset_color%}'
  local git='%{$fg[yellow]%}$(show_git_branch)%{$fg[red]%}$(show_git_status)%{$reset_color%}'

  PROMPT="[$user@$host] $dir $ruby $git%% "
fi
