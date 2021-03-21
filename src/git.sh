alias gcm="git commit -m"
alias gs="git status"
alias g="git"
alias gca="git commit --amend"
alias gcob="git checkout -b"
alias ga="git add"
alias gcp="git cherry-pick"

function git-branch-clean () {
  git branch --merged | grep -v \* | xargs git branch -D
}

export GPG_TTY=$(tty)
