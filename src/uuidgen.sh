#!/bin/bash

uuidgen() {
    text=$(/usr/bin/uuidgen | gtr '[:upper:]' '[:lower:]')
    echo "$text" | pbcopy
    echo "$text"
}
