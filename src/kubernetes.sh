#!/bin/bash

if [[ -d "${HOME}/.krew" ]]; then
    # export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
    export PATH="${PATH}:${HOME}/.krew/bin"
fi
