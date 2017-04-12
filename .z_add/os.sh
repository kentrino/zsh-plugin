uname -a | grep 'Darwin' >/dev/null 2>&1
if [ $? -eq 0 ]; then
  export MAC_OS=true
else
  export MAC_OS=false
fi
