#!/bin/bash

# http://unix.stackexchange.com/questions/30058/how-can-i-check-which-terminal-definitions-are-available

for term in screen-256color xterm-256color xterm-color screen xterm rxvt; do
    if tput -t$term cols >/dev/null 2>/dev/null; then
        echo "set -g default-terminal \"$term\""
        break
    fi
done
