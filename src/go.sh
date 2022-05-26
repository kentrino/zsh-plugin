#!/bin/bash

# shellcheck disable=SC3033
initialize-go-environment() {
    if type "go" >/dev/null 2>&1; then
        GOROOT=$(go env GOROOT)
        export GOROOT
        export GOPATH=/Users/dev/go
        export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"
    fi
}
