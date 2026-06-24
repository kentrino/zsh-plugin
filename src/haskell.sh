#!/bin/bash

if [ -f "${HOME}/.ghcup/env" ]; then
    # shellcheck disable=SC1091
    source "${HOME}/.ghcup/env" # ghcup-env
fi
