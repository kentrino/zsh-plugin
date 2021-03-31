function get-computer-name () {
  scutil --get ComputerName
}

function pwd() {
  pwd | pbcopy
}
