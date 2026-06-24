#!/bin/bash

# shellcheck disable=SC1091
source "$DIRECTORY/src/common/brew-prefix.sh"

# https://asdf-vm.com/guide/getting-started.html
if asdf_prefix="$(brew_prefix asdf)"; then
    asdf_source="$asdf_prefix/libexec/asdf.sh"
    if [ -s "$asdf_source" ]; then
        #shellcheck disable=SC1090
        . "$asdf_source"
        fpath=("${ASDF_DIR}/completions" "${fpath[@]}")
    fi
fi

if [ -s "$HOME/.asdf/asdf.sh" ]; then
    #shellcheck disable=SC1091
    . "$HOME/.asdf/asdf.sh"
fi
