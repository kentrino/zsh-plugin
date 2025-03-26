#!/bin/bash

export PATH="$PATH:$HOME/.pub-cache/bin"
export PATH="$PATH:$HOME/flutter/bin"
export ANDROID_HOME=~/Library/Android/sdk

# Completion scripts setup. Remove the following line to uninstall
if [[ -f "$HOME/.dart-cli-completion/zsh-config.zsh" ]]; then
    # shellcheck disable=SC1091
    . "$HOME/.dart-cli-completion/zsh-config.zsh"
fi
