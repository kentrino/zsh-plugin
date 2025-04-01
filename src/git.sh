#!/bin/bash

# alias gcm="git commit -m"
alias gs="git status"
alias g="git"
alias gca="git commit --amend"
alias gco="git checkout"
alias gcob="git checkout -b"
alias ga="git add"
alias gcp="git cherry-pick"

function git-branch-clean() {
    # shellcheck disable=SC2063
    git branch --merged | grep -v \* | xargs git branch -D
}
