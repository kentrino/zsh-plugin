#!/bin/bash

ls-all() {
    emulate -L zsh
    if type "exa" >/dev/null 2>&1; then
        exa --header --group --long --all
    else
        ls -la
    fi
}

chpwd_functions=("${chpwd_functions[@]}" "ls-all")
