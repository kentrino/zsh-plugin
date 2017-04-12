# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# anyenv =====================================================================
if type anyenv > /dev/null 2>&1; then
  export PATH=$HOME/.anyenv/bin:$PATH
  eval "$(anyenv init -)"
  export USE_ANYENV=true
fi

# peco =======================================================================
# for f (~/.peco/*) source "${f}"
function peco-history-selection() {
    BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | peco`
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

# Source z ===================================================================
source ~/.z_script/z.sh

# automatical run ls after every cd ==========================================
function list_all() {
    emulate -L zsh
    ls -la
}
chpwd_functions=(${chpwd_functions[@]} "list_all")

# python =====================================================================
if type pyenv > /dev/null 2>&1 && ! $USE_ANYENV; then 
  export PYENV_ROOT=$HOME/.pyenv
  export PATH=$PYENV_ROOT/bin:$PATH
  eval "$(pyenv init -)"
fi

# conda
activate () {
  source $HOME/.pyenv/versions/`pyenv global`/bin/activate $1
}

deactivate () {
  source $HOME/.pyenv/versions/`pyenv global`/bin/deactivate
}

# direnv =====================================================================
if type direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# rbenv ======================================================================
if type rbenv > /dev/null 2>&1 && ! $USE_ANYENV; then 
  rbenv-init() {
    eval "$(rbenv init -)"
  }
  export PATH="$HOME/.rbenv/shims:$PATH"
fi

# Git ========================================================================
alias gcm="git commit -m"
alias gs="git status"
alias g="git"
alias gca="git commit --amend"
alias gcob="git checkout -b"
alias ga="git add"

# Go =========================================================================
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/go

# Default Editor =============================================================
export VISUAL=vim
export EDITOR="$VISUAL"

# Rails aliases ==============================================================
alias rc="bundle exec rails console"
alias rs="bundle exec foreman start"
alias ru="FAIL_FAST=true bundle exec rake test:units"

rt () {
  if [ -z "$2" ]; then
    FAIL_FAST=true bundle exec rake test TEST=$1
  else
    FAIL_FAST=true bundle exec rake test TEST=$1 TESTOPTS="--name=$2"
  fi
}

