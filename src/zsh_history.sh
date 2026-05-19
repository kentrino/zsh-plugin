zshaddhistory() {
  emulate -L zsh

  local line=${1##[[:space:]]#}

  [[ $line == rm(|\ *) ]] && return 1
  [[ $line == sudo\ rm(|\ *) ]] && return 1
  [[ $line == command\ rm(|\ *) ]] && return 1
  [[ $line == noglob\ rm(|\ *) ]] && return 1

  return 0
}
