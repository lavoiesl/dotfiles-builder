#!/bin/bash

if program_exists tput && tput colors >/dev/null; then
    echo "autoload -U promptinit"
    echo "promptinit"
    echo "PROMPT='%F{magenta}[%~] %f"
else
    echo "PROMPT='[%~] '"
fi
