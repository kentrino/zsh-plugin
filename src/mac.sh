#!/bin/bash

function get-computer-name() {
    scutil --get ComputerName
}

function pwd() {
    local working_dir
    working_dir=$(/bin/pwd)
    echo "$working_dir" | pbcopy
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
