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

# Clear conflicting options even when reloading an older running shell.
unsetopt INC_APPEND_HISTORY INC_APPEND_HISTORY_TIME
# share history across tabs/terminals
setopt SHARE_HISTORY

# SHARE_HISTORY does not import while ZLE is waiting for input. Import before
# history navigation and insertion (before autosuggestions fetch their result).
# Keep existing widgets, and register only once so sourcing again is safe.
() {
  local widget original
  for widget in self-insert self-insert-unmeta bracketed-paste \
      up-line-or-history down-line-or-history up-history down-history \
      history-beginning-search-backward history-beginning-search-forward \
      history-search-backward history-search-forward \
      history-incremental-search-backward history-incremental-search-forward; do
    original="_kentrino_history_original_${widget}"
    (( ${+widgets[$original]} )) && continue
    zle -A "$widget" "$original"
    # Use an explicit widget name: other plugins may invoke us without zle -w.
    eval "_kentrino_history_${widget}() {
      [[ -r \$HISTFILE ]] && builtin fc -RI
      zle ${(q)original} -- \"\$@\"
    }"
    zle -N "$widget" "_kentrino_history_${widget}"
  done
}

zshaddhistory() {
  emulate -L zsh

  local line=${1##[[:space:]]#}

  [[ $line == rm(|\ *) ]] && return 1
  [[ $line == sudo\ rm(|\ *) ]] && return 1
  [[ $line == command\ rm(|\ *) ]] && return 1
  [[ $line == noglob\ rm(|\ *) ]] && return 1

  return 0
}
