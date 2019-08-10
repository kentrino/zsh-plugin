export PATH=./node_modules/.bin:$PATH

# nodebrew
if [ -e "$HOME/.nodebrew" ]; then
  export PATH=$HOME/.nodebrew/current/bin:$PATH
fi

if command -v nodenv &>/dev/null; then
  eval "$(nodenv init -)"
fi
