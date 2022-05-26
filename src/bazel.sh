#!/bin/bash

if [ -e "$HOME/.bazel" ]; then
    PATH="$HOME/.bazel/bin/:$PATH"
fi
