#!/bin/bash

alias ghc="stack ghc"
alias ghci="stack ghci"
alias runghc="stack runghc"

[ -f "${HOME}/.ghcup/env" ] && source "${HOME}/.ghcup/env" # ghcup-env
