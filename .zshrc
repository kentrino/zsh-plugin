# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [ -e ~/.zshrc_vars ]; then
  source ~/.zshrc_vars
fi

function z_add () {
  lib=${1:?"You have to specify a library name"}
  lib_path="$HOME/.z_add/$lib.sh"
  if [ -f "$lib_path" ];then
    source "$lib_path"
  fi
}

z_add 'os'
z_add 'anyenv'
z_add 'peco'
z_add 'z'
z_add 'python'
z_add 'ruby'
z_add 'git'
z_add 'direnv'
z_add 'go'
z_add 'editor'
z_add 'cd_ls'
z_add 'haskell'
z_add 'node'
z_add 'terraform'
z_add 'rust'
z_add 'java'
