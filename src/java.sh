#!/bin/bash

initialize-sdkman-environment() {
    if [ -e "$HOME/.sdkman" ]; then
        export SDKMAN_DIR="$HOME/.sdkman"
        # shellcheck disable=SC1091
        source "$HOME/.sdkman/bin/sdkman-init.sh"
    fi
}
