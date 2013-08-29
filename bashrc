unset MAILCHECK

umask 0022

for file in ~/.shrc/*.sh; do
  source "$file"
done

if [ -f ~/.bashrc.local ]; then
  . ~/.bashrc.local
fi
