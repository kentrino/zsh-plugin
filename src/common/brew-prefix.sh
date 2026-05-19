#!/bin/bash

# Resolve and cache the Homebrew prefix so callers can avoid repeated
# `brew --prefix` subshells (each fork costs ~50-200ms on macOS).
#
# Exports:
#   BREW_PREFIX        - global Homebrew prefix, e.g. /opt/homebrew
#
# Functions:
#   brew_prefix [formula]
#     - With no argument: prints $BREW_PREFIX and returns 0 if it's set.
#     - With a formula: prints the formula's prefix via the cached
#       $BREW_PREFIX/opt/<formula> symlink (no fork) and returns 0 if the
#       formula is installed, or returns 1 silently otherwise.

if [ -z "${BREW_PREFIX:-}" ]; then
    if [ -n "${HOMEBREW_PREFIX:-}" ]; then
        BREW_PREFIX="$HOMEBREW_PREFIX"
    elif [ -x "/opt/homebrew/bin/brew" ]; then
        BREW_PREFIX="/opt/homebrew"
    elif [ -x "/usr/local/bin/brew" ]; then
        BREW_PREFIX="/usr/local"
    elif command -v brew >/dev/null 2>&1; then
        BREW_PREFIX="$(brew --prefix)"
    fi
    export BREW_PREFIX
fi

brew_prefix() {
    local formula="${1:-}"
    if [ -z "$formula" ]; then
        [ -n "${BREW_PREFIX:-}" ] || return 1
        printf '%s' "$BREW_PREFIX"
        return 0
    fi
    if [ -n "${BREW_PREFIX:-}" ] && [ -d "$BREW_PREFIX/opt/$formula" ]; then
        printf '%s' "$BREW_PREFIX/opt/$formula"
        return 0
    fi
    return 1
}
