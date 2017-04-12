if type anyenv > /dev/null 2>&1; then
  export PATH=$HOME/.anyenv/bin:$PATH
  eval "$(anyenv init -)"
  export USE_ANYENV=true
fi
