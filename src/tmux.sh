#!/bin/bash

# Resources
# How to check if a variable is set in Bash
# https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash

# -u: exit the script on the use of undefined variable
# -e: exit the script on error
# set -eu

# function select-predefined-tmux-session() {
#     local green='\033[0;32m'
#     local red='\033[0;31m'
#     local nc='\033[0m'
#     local detach='[Detatch]'
#     local command_file=~/.tmux.yml

#     local candidate_names
#     candidate_names=$(yq keys "$command_file" | sed -e 's/- //')

#     local current_sessions
#     current_sessions=$(tmux list-sessions)

#     local candidates
#     candidates=$()

#     for name in $candidate_names; do
#         local contains
#         contains=$(echo "$current_sessions" | grep -o "$name" | wc -w)
#         # number equal
#         if [ "$contains" -ne 0 ]; then
#             # if session is started
#             # first $ enable to contain new line character
#             candidates=$(printf "%s\n%s%s%s" "$candidates" "$green" "$name" "$nc")
#         else
#             # if session is not started
#             candidates=$(printf "%s\n%s%s%s" "$candidates" "$red" "$name" "$nc")
#         fi
#     done

#     if [ -n "${TMUX+x}" ]; then
#         candidates=$(printf "%s\n%s" "$candidates" "$detach")
#     fi

#     local selected
#     selected=$(echo "$candidates" | awk 'NF' | fzf --ansi)

#     if [ "$selected" = "" ]; then
#         # do nothing
#         exit 0
#     elif [ "$selected" = "$detach" ]; then
#         if [ -n "$TMUX" ]; then
#             tmux detach
#         fi
#     else
#         local current_directory
#         current_directory=$(yq ".$selected.cd" "$command_file")
#         local command
#         command=$(yq ".$selected.command" "$command_file")
#         local contains
#         contains=$(echo "$current_sessions" | grep -o "$selected" | wc -w)
#         if [ "$contains" -ne 0 ]; then
#             # if session is started
#             if [ -n "${TMUX+x}" ]; then
#                 # in tmux session
#                 tmux switch -t "$selected"
#             else
#                 # outside tmux session
#                 tmux attach-session -t "$selected"
#             fi
#         else
#             # if session is not started
#             tmux new -s "$selected" -c "$current_directory" "$command"
#         fi
#     fi
# }

function select-tmux-session() {
    if [ -n "$TMUX" ]; then
        local SELECTED="$(tmux list-sessions | peco | cut -d : -f 1)"
        tmux switch-client -t $SELECTED
        return 0
    else
        local SELECTED="$(tmux list-sessions | peco | cut -d : -f 1)"
        tmux attach-session -t $SELECTED
        return 0
    fi
}
