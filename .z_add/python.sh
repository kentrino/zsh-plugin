export PYENV_ROOT=$HOME/.pyenv
if [ -e $PYENV_ROOT ] && ! $USE_ANYENV; then
  export PATH=$PYENV_ROOT/bin:$PATH
  if $PYENV_EAGER_INIT; then
    eval "$(pyenv init -)"
  else
    function pyenv-init () {
      eval "$(pyenv init -)"
    }
  fi
fi

if type pyenv > /dev/null 2>&1; then
  if $USE_ANYENV; then
    activate_path="$HOME/.anyenv/envs/pyenv/versions/`pyenv global`/bin"
  else
    activate_path="$HOME/.pyenv/versions/`pyenv global`/bin"
  fi

  activate () {
    source $activate_path/activate $1
  }

  deactivate () {
    source $activate_path/deactivate
  }
fi
