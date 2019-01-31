export PATH=./node_modules/.bin:$PATH

# nodebrew
if [ -e "$HOME/.nodebrew" ]; then
  export PATH=$HOME/.nodebrew/current/bin:$PATH
fi
