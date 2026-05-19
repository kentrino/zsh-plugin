export HISTFILE=${HOME}/.zsh_history
# number of commands in memoery
export HISTSIZE=1000000
# number of commands in file
export SAVEHIST=100000000

# https://unix.stackexchange.com/questions/568907/why-do-i-lose-my-zsh-history
setopt hist_save_no_dups

# ref:
#   https://qiita.com/ykit00/items/94393d4c55b0b659a267
#   https://zenn.dev/rclab/articles/present_my_zshrc
# record timestamp
setopt extended_history

# share history across tabs/terminals (incompatible with INC_APPEND_HISTORY_TIME)
setopt SHARE_HISTORY

# INC_APPEND_HISTORY_TIME: writes history with duration after command finishes,
#   but overrides SHARE_HISTORY and disables cross-tab sharing
# setopt INC_APPEND_HISTORY_TIME

# Setting for per-directory-history
HISTORY_START_WITH_GLOBAL=true

zshaddhistory() {
  emulate -L zsh

  local line=${1##[[:space:]]#}

  [[ $line == rm(|\ *) ]] && return 1
  [[ $line == sudo\ rm(|\ *) ]] && return 1
  [[ $line == command\ rm(|\ *) ]] && return 1
  [[ $line == noglob\ rm(|\ *) ]] && return 1

  return 0
}
