#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# peco =====================================================================
# for f (~/.peco/*) source "${f}"
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# pecoでgit add
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
bindkey '^g^b' peco-branch # C-x b でブランチ選択

# Source z ================================================================
source ~/.z_script/z.sh

# automatical run ls after every cd =======================================
function list_all() {
    emulate -L zsh
    ls -la
}
chpwd_functions=(${chpwd_functions[@]} "list_all")

# move to my directory ====================================================
alias k="cd ~/../kento"

# init path
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi
export PATH=/usr/local/bin:$PATH

# node
export PATH=./node_modules/.bin:$PATH

# Customize to your needs...
# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# direnv
export EDITOR=zsh
eval "$(direnv hook zsh)"
 
# editor
export EDITOR=vim


# rbenv
rbenv-init() {
  eval "$(rbenv init -)"
}
export PATH="$HOME/.rbenv/shims:$PATH"

# Haskell
alias ghc="stack ghc"
alias ghci="stack ghci"
alias runghc="stack runghc"
export PATH=$PATH:$HOME/.local/bin

# git
alias gcm="git commit -m"
alias gs="git status"
alias g="git"
alias gca="git commit --amend"
alias gcob="git checkout -b"
alias ga="git add"

# docker 
function docker-enable(){
  if [[ -n $1 ]]; then
    eval $(docker-machine env default)
  fi
  eval $(docker-machine env $1)
}

function docker-clean(){
  if [[ $1 == 'container' ]]; then
    docker rm $(docker ps -q -a)
  elif [[ $1 == 'volume' ]]; then
    docker volume rm $(docker volume ls -q)
  else
    echo 'clean all'
    docker kill $(docker ps -q)
    docker rm $(docker ps -a -q)
    docker volume rm $(docker volume ls -q)
#    docker rmi --force $(docker images -q)
  fi
}

# objc2swift 
alias objc2swift='java -jar /usr/local/objc2swift/build/libs/objc2swift-1.0.jar'

# golang
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/go

# Visual Studio Code
vs () {
  VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;
}

# py
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:$PATH"

pyenv-init() {
  eval "$(pyenv init -)"
}

# set default editor.
export VISUAL=vim
export EDITOR="$VISUAL"


# rails aliases
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

