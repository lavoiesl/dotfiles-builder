#!/bin/bash

# skip is oh-my-zsh, which handles everything
if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
    if program_exists tput && tput colors >/dev/null; then
        echo "autoload -U promptinit"
        echo "promptinit"
        echo "PROMPT='%F{magenta}[%~] %f'"
    else
        echo "PROMPT='[%~] '"
    fi
fi
