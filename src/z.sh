#!/bin/bash

z_file="$HOME/.z_script/z.sh"

if [ -e "$z_file" ]; then
    # shellcheck disable=SC1090
    source "$z_file"
fi
