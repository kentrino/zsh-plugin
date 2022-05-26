#!/bin/bash

initialize-sdkman-environment() {
    # sdkman
    if command -v sdk 1>/dev/null 2>&1; then
        export SDKMAN_DIR="$HOME/.sdkman"
        # shellcheck disable=SC1091
        [ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"
    fi
}
