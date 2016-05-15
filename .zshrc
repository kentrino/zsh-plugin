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

# automatical run ls after every cd ======================
function list_all() {
    emulate -L zsh
    ls -la
}
chpwd_functions=(${chpwd_functions[@]} "list_all")

# move to my directory ==================================
alias k="cd ~/../kento"

# init path
PATH=
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi
export PATH=/usr/local/bin:$PATH

# Customize to your needs...
# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# direnv
export EDITOR=zsh
eval "$(direnv hook zsh)"
 
# editor
export EDITOR=vim


# rbenv
eval "$(rbenv init -)"
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
  eval $(docker-machine env $1)
}


