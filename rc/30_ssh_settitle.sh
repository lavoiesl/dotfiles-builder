#!/bin/bash

echo '
if [ -n "$TMUX" ]; then
    settitle() {
        printf "\033k$1\033\\"
    }

    ssh() {
        settitle "$($* | head -c 20)"
        command ssh "$@"
        settitle "'$shell'"
    }
fi'
