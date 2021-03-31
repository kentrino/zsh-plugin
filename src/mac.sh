function get-computer-name () {
  scutil --get ComputerName
}

export __pwd=$(which pwd)

function pwd() {
  $__pwd | pbcopy
}
