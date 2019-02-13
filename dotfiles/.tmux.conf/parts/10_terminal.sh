#!/bin/bash

# http://unix.stackexchange.com/questions/30058/how-can-i-check-which-terminal-definitions-are-available

for term in xterm-256color screen-256color xterm-color screen xterm rxvt; do
    if tput -T $term cols >/dev/null 2>/dev/null; then
        echo "set -g default-terminal \"$term\""
        if [[ "$term" = "xterm-256color" ]]; then
            # Support for italics
            # https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be
            echo "set -as terminal-overrides ',xterm*:Tc:sitm=\E[3m'"
        fi
        break
    fi
done
