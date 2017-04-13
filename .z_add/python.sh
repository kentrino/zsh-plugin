#
if [ -e "$HOME/.pyenv" ] && ! $USE_ANYENV; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  if [ "$PYENV_EAGER_INIT" = 'true' ]; then
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
