#!/bin/bash

initialize-anyenv-environment() {
    if type anyenv >/dev/null 2>&1; then
        export PATH="$HOME/.anyenv/bin:$PATH"
        eval "$(anyenv init -)"
    fi
}
