#!/bin/bash

if program_exists tmux; then
    if [[ "$(uname)" == "Darwin" ]]; then
        echo 'if ! [[ "$(ps -ocomm= $PPID)" =~ \/Applications\/.+\.app ]]; then
  export ZSH_TMUX_AUTOSTART=true
fi'
    else
        echo 'export ZSH_TMUX_AUTOSTART=true'
    fi
fi