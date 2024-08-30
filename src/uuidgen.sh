#!/bin/bash

uuidgen() {
    text=$(/usr/bin/uuidgen | gtr '[:uppper:]' '[:lower:]')
    echo "$text" | pbcopy
    echo "$text"
}
