#!/bin/bash

# shellcheck disable=SC1091
export LANG=en_US.UTF-8

DIRECTORY=$(dirname "$0":A)

source "$DIRECTORY/src/coreutils.sh"

source "$DIRECTORY/src/anyenv.sh"
source "$DIRECTORY/src/asdf.sh"
source "$DIRECTORY/src/bazel.sh"
source "$DIRECTORY/src/bindkey.sh"
source "$DIRECTORY/src/cd-ls.sh"
# source "$DIRECTORY/src/change-current-directory.sh"
source "$DIRECTORY/src/code.sh"
source "$DIRECTORY/src/direnv.sh"
source "$DIRECTORY/src/docker.sh"
source "$DIRECTORY/src/editor.sh"
source "$DIRECTORY/src/eza.sh"
source "$DIRECTORY/src/flutter.sh"
source "$DIRECTORY/src/git.sh"
source "$DIRECTORY/src/go.sh"
source "$DIRECTORY/src/gpg.sh"
source "$DIRECTORY/src/haskell.sh"
source "$DIRECTORY/src/java.sh"
source "$DIRECTORY/src/jetbrains.sh"
source "$DIRECTORY/src/mac.sh"
source "$DIRECTORY/src/node.sh"
source "$DIRECTORY/src/peco.sh"
source "$DIRECTORY/src/pg.sh"
source "$DIRECTORY/src/php.sh"
source "$DIRECTORY/src/python.sh"
source "$DIRECTORY/src/ripgrep.sh"
source "$DIRECTORY/src/rust.sh"
source "$DIRECTORY/src/tmux.sh"
source "$DIRECTORY/src/util.sh"
source "$DIRECTORY/src/uuidgen.sh"
source "$DIRECTORY/src/z.sh"
