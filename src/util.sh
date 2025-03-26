#!/bin/bash

dev() {
    target=$(fd . /Users/dev --max-depth 2 --type d --changed-within=10w | sed 's/\/Users\/dev\///' | fzf --ansi --no-sort)
    cd "/Users/dev/$target" || exit
}

..() {
    cd ..
}

start() {
    comment=$1
    if [[ -n "${comment}" ]]; then
        git add .
        git commit -m "$comment"
    else
        echo "please specify comment."
    fi
}
