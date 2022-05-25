#!/bin/sh

# shellcheck disable=SC3033
initialize-sdkman-environment() {
  # sdkman
  if command -v sdk 1>/dev/null 2>&1; then
    export SDKMAN_DIR="$HOME/.sdkman"
    [ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && . "$HOME/.sdkman/bin/sdkman-init.sh"
  fi
}

initialize-sdkman-environment &
