#!/bin/bash

if type "eza" >/dev/null 2>&1; then
    alias ls='eza --header --group --long --all'
fi
