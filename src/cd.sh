#!/bin/bash

ls-all() {
    # emulate -L zsh
    if type "eza" >/dev/null 2>&1; then
        eza --header --group --long --all
    else
        ls -la
    fi
}

# chpwd_functions break oh-my-zsh plugins
# chpwd_functions=("${chpwd_functions[@]}" "ls-all")

cd() {
    # exit if cd fails
    builtin cd "$@"
    ls-all
}

# Change directory by just typing directory name
setopt AUTO_CD
# Automatically pushd when cd
setopt AUTO_PUSHD
# Don't push duplicate directories onto the stack
setopt PUSHD_IGNORE_DUPS

# limit history size
export DIRSTACKSIZE
DIRSTACKSIZE=100
