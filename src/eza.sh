#!/bin/bash

if type "eza" >/dev/null 2>&1; then
    alias l='eza --header --group --long --all'
fi
