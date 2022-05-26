#!/bin/bash

function get-computer-name() {
    scutil --get ComputerName
}

# zsh have built-in pwd,
# so `which pwd` returns `pwd: shell built-in command`
__pwd=$(whereis pwd)
export __pwd

function pwd() {
    local working_dir
    working_dir=$("$__pwd")
    echo "$working_dir" | pbcopy
    echo "$working_dir"
}
