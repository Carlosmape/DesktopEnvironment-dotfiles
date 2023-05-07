#!/bin/sh

echo "󰏗"
if [[ $(checkupdates 2> /dev/null | wc -l) -ge 1 ]]; then
    echo "󱧕"
fi
