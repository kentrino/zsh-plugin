#!/bin/bash

change-current-directory() {
    current_directory="$(pwd)/"
    current_directory_escaped="$(echo $current_directory | sed 's/\//\\\//g')"

    selected=$(fd . "$current_directory" --max-depth 2 --type d | sed -e "s/$current_directory_escaped//" | fzf)
    if [ -n "$selected" ]; then
        BUFFER="cd $current_directory$selected"
        zle redisplay
    fi
}

zle -N change-current-directory
bindkey '^z' change-current-directory
