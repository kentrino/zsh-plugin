uname -a | grep 'Ubuntu' >/dev/null 2>&1
if [ $? -eq 0 ]; then
  autoload -Uz compinit
  compinit
fi
source ~/.zshenv_prezto