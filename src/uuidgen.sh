#!/bin/bash

uuidgen() {
    text=$(/usr/bin/uuidgen | tr '[:uppper:]' '[:lower:]')
    echo "$text" | pbcopy
    echo "$text"
}
