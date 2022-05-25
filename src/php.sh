#!/bin/sh

# shellcheck disable=SC3033
initialize-phpenv-environment() {
  if type phpenv > /dev/null 2>&1; then
      eval "$(phpenv init -)"
  fi
}

initialize-phpenv-environment &
