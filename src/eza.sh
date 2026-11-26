#!/bin/bash

if type "eza" >/dev/null 2>&1; then
    unalias ls 2>/dev/null || true
    function ls() {
        if [[ $- == *i* && -t 0 && -t 1 && ${TERM:-dumb} != dumb && -z ${CLAUDECODE:-}${CODEX_CI:-}${CODEX_SANDBOX:-}${CURSOR_AGENT:-}${CI:-} ]]; then
            eza --header --group --long --all "$@"
        else
            command ls "$@"
        fi
    }
fi
