function get-computer-name () {
  scutil --get ComputerName
}

# zsh have built-in pwd,
# so `which pwd` returns `pwd: shell built-in command`
export __pwd=$(whereis pwd)

function pwd() {
  working_dir=$("$__pwd")
  echo $working_dir | pbcopy
  echo $working_dir
}
