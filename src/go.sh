if type "go" > /dev/null 2>&1; then
  export GOROOT=$(go env GOROOT)
  export GOPATH=/Users/dev/go
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi
