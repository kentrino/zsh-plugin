export PATH=$HOME/.anyenv/bin:$PATH
if type anyenv > /dev/null 2>&1; then
  eval "$(anyenv init -)"
  export USE_ANYENV=true
fi
