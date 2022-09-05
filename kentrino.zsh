#!/bin/bash

# shellcheck disable=SC1091
export LANG=en_US.UTF-8

DIRECTORY=$(dirname "$0":A)

source "$DIRECTORY/src/anyenv.sh"
source "$DIRECTORY/src/asdf.sh"
source "$DIRECTORY/src/bazel.sh"
source "$DIRECTORY/src/cd_ls.sh"
source "$DIRECTORY/src/code.sh"
source "$DIRECTORY/src/direnv.sh"
source "$DIRECTORY/src/editor.sh"
source "$DIRECTORY/src/exa.sh"
source "$DIRECTORY/src/flutter.sh"
source "$DIRECTORY/src/git.sh"
source "$DIRECTORY/src/go.sh"
source "$DIRECTORY/src/haskell.sh"
source "$DIRECTORY/src/java.sh"
source "$DIRECTORY/src/jetbrains.sh"
source "$DIRECTORY/src/mac.sh"
source "$DIRECTORY/src/node.sh"
source "$DIRECTORY/src/peco.sh"
source "$DIRECTORY/src/php.sh"
source "$DIRECTORY/src/python.sh"
source "$DIRECTORY/src/rust.sh"
source "$DIRECTORY/src/sdkman.sh"
source "$DIRECTORY/src/util.sh"
source "$DIRECTORY/src/uuidgen.sh"
source "$DIRECTORY/src/z.sh"

initialize() {
    enable-asdf
    initialize-anyenv-environment
    initialize-go-environment
    initialize-phpenv-environment
    initialize-python-environment
    initialize-sdkman-environment
    # To avoid error around 'Visutal Studio Code'
    env | sed -r 's/(.+)=(.+)/\1="\2"/' | grep -v 'PWD=' | grep -v 'GPG_TTY' >/tmp/startup-env
}

(initialize &) >>/dev/null 2>&1
wait
source /tmp/startup-env
rm -rf /tmp/startup-env
