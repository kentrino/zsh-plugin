if type pyenv > /dev/null 2>&1 && ! $USE_ANYENV; then 
  export PYENV_ROOT=$HOME/.pyenv
  export PATH=$PYENV_ROOT/bin:$PATH
  eval "$(pyenv init -)"
fi

if $USE_ANYENV; then
  activate_path="$HOME/.anyenv/envs/pyenv/versions/`pyenv global`/bin"
else
  activate_path="$HOME/.pyenv/versions/`pyenv global`/bin"
fi

# conda
activate () {
  source $activate_path/activate $1
}

deactivate () {
  source $activate_path/deactivate
}
