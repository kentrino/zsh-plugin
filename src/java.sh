if [ -e "$HOME/.sdkman" ]; then
  export SDKMAN_DIR="$HOME/.sdkman"
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
