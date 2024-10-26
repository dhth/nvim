#/usr/bin/env bash

if ! command -v stylua >/dev/null 2>&1; then
    echo "Error: stylua is not installed."
    exit 1
fi

stylua init.lua lua
