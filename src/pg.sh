#!/bin/bash

# shellcheck disable=SC1091
source "$DIRECTORY/src/common/brew-prefix.sh"

if libpq_prefix="$(brew_prefix libpq)"; then
    export PATH="$libpq_prefix/bin:$PATH"
fi
