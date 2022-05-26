#!/bin/bash

initialize-phpenv-environment() {
    if type phpenv >/dev/null 2>&1; then
        eval "$(phpenv init -)"
    fi
}
