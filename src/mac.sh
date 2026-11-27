#!/bin/bash

function get-computer-name() {
    scutil --get ComputerName
}

function pwd() {
    local working_dir
    working_dir=$(/bin/pwd "$@") || return
    if [[ $- == *i* && -t 0 && -t 1 && ${TERM:-dumb} != dumb && -z ${CLAUDECODE:-}${CODEX_CI:-}${CODEX_SANDBOX:-}${CURSOR_AGENT:-}${CI:-} ]]; then
        printf '%s' "$working_dir" | pbcopy
    fi
    echo "$working_dir"
}

function configure-mac() {
    # https://gist.github.com/mbinna/2357277
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
    defaults write NSGlobalDomain KeyRepeat -int 1
    defaults write NSGlobalDomain InitialKeyRepeat -int 12

    defaults write com.apple.systemaudio "com.apple.sound.uiaudio.enabled" -bool NO

    # Disallow Blootooth devices to wake this computer
    defaults -currentHost write com.apple.Bluetooth RemoteWakeEnabled 0
}
