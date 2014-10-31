#!/bin/bash

if program_exists tput && tput colors >/dev/null; then
    echo "PROMPT='%{\$fg[magenta]%}[%~] %{\$reset_color%}'"
else
    echo "PROMPT='[%~] '"
fi
