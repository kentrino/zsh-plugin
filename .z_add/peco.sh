# for f (~/.peco/*) source "${f}"
function peco-history-selection() {
    if $MAC_OS; then
      BUFFER=`history -n 1 | tail -r | awk '!a[$0]++' | peco`
    else
      BUFFER=`history -n 1 | tac | awk '!a[$0]++' | peco`
    fi
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# git add with peco
function peco-select-gitadd() {
    local SELECTED_FILE_TO_ADD="$(git status --porcelain | \
                                  peco --query "$LBUFFER" | \
                                  awk -F ' ' '{print $NF}')"
    if [ -n "$SELECTED_FILE_TO_ADD" ]; then
        BUFFER="git add $(echo "$SELECTED_FILE_TO_ADD" | tr '\n' ' ')"
        CURSOR=$#BUFFER
    fi
    zle accept-line
    # zle clear-screen
}
zle -N peco-select-gitadd
bindkey "^g^a" peco-select-gitadd

function peco-branch () {
    local branch=$(git branch -a | peco | tr -d ' ' | tr -d '*')
    if [ -n "$branch" ]; then
      if [ -n "$LBUFFER" ]; then
        local new_left="${LBUFFER%\ } $branch"
      else
        local new_left="$branch"
      fi
      BUFFER=${new_left}${RBUFFER}
      CURSOR=${#new_left}
    fi
}

zle -N peco-branch
# select branch with C-x b
bindkey '^g^b' peco-branch
