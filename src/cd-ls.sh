#!/bin/bash

ls-all() {
    emulate -L zsh
    if type "eza" >/dev/null 2>&1; then
        eza --header --group --long --all
    else
        ls -la
    fi
}

chpwd_functions=("${chpwd_functions[@]}" "ls-all")
