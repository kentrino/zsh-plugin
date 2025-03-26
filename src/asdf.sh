#!/bin/bash

# shellcheck disable=SC1091
source "./common/brew-prefix.sh"

# https://asdf-vm.com/guide/getting-started.html
asdf_source="$BREW_PREFIX/libexec/asdf.sh"

if [ -s "$asdf_source" ]; then
    #shellcheck disable=SC1090
    . "$asdf_source"
    # append completions to fpath
    fpath=("${ASDF_DIR}/completions" "${fpath[@]}")
fi

if [ -s "$HOME/.asdf/asdf.sh" ]; then
    #shellcheck disable=SC1091
    . "$HOME/.asdf/asdf.sh"
fi
