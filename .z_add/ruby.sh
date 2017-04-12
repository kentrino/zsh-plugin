if type rbenv > /dev/null 2>&1 && ! $USE_ANYENV; then 
  rbenv-init() {
    eval "$(rbenv init -)"
  }
  export PATH="$HOME/.rbenv/shims:$PATH"
fi

# Rails aliases
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
