if [ -e "$HOME/.anyenv" ]; then
  export PATH=$HOME/.anyenv/bin:$PATH
  if $ANYENV_EAGER_INIT; then
    eval "$(anyenv init -)"
  else
    function anyenv-init () {
      eval "$(anyenv init -)"
    }
  fi
  export USE_ANYENV=true
fi
