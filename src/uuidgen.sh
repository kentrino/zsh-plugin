uuidgen () {
  # shellcheck disable=SC2018
  text=$(/usr/bin/uuidgen | tr A-Z a-z)
  echo "$text" | pbcopy
  echo "$text"
}
