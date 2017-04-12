# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

function z_add () {
  lib=${1:?"You have to specify a library name"}
  lib_path="$HOME/.z_add/$lib.sh"
  if [ -f "$lib_path" ];then
    source "$lib_path"
  fi
}

z_add 'test'

# peco =======================================================================
# for f (~/.peco/*) source "${f}"
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
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

# anyenv =====================================================================
export PATH=$HOME/.anyenv/bin:$PATH
eval "$(anyenv init -)"

# Node.js ====================================================================
# nodebrew
#export PATH=$HOME/.nodebrew/current/bin:$PATH

export PATH=./node_modules/.bin:$PATH

# direnv =====================================================================
eval "$(direnv hook zsh)"

# rbenv ======================================================================
#rbenv-init() {
#  eval "$(rbenv init -)"
#}
#export PATH="$HOME/.rbenv/shims:$PATH"

# Haskell ====================================================================
alias ghc="stack ghc"
alias ghci="stack ghci"
alias runghc="stack runghc"
export PATH=$PATH:$HOME/.local/bin

# Git ========================================================================
alias gcm="git commit -m"
alias gs="git status"
alias g="git"
alias gca="git commit --amend"
alias gcob="git checkout -b"
alias ga="git add"

# Docker =====================================================================
function docker-clean(){
  if [[ $1 == 'container' ]]; then
    docker rm $(docker ps -q -a)
  elif [[ $1 == 'volume' ]]; then
    docker volume rm $(docker volume ls -q)
  elif [[ $1 == 'all' ]]; then
    docker kill $(docker ps -q)
    docker rm $(docker ps -a -q)
    docker volume rm $(docker volume ls -q)
    docker rmi --force $(docker images -q)
  fi
}

# Go =========================================================================
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/go

# Visual Studio Code =========================================================
vs () {
  VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;
}

# Python =====================================================================
#export PYENV_ROOT="${HOME}/.pyenv"
#export PATH="${PYENV_ROOT}/bin:$PATH"

# pyenv-init() {
#  eval "$(pyenv init -)"
#}

# Default editor =============================================================
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

