#!/bin/bash

if program_exists tput && tput colors >/dev/null; then
    echo "autoload -U promptinit"
    echo "promptinit"
    # http://unix.stackexchange.com/questions/71974/preventing-zsh-from-using-aliases-in-cwd-prompt
    echo "PROMPT='%F{magenta}[\${\${PWD/#%\$HOME/~}/#\$HOME\//~/}] %f'"
else
    echo "PROMPT='[%~] '"
fi
