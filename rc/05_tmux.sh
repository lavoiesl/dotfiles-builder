#!/bin/bash

if program_exists tmux; then
    if [[ "$(uname)" == "Darwin" ]]; then
        echo '
if ! [[ "$(ps -ocomm= $PPID)" =~ \/Applications\/.+\.app ]]; then
  export ZSH_TMUX_AUTOSTART=true
fi'
    else
        echo '
export ZSH_TMUX_AUTOSTART=true'
    fi

    echo '
if [ -n "$TMUX" ]; then
    tmup ()
    {
        echo -n "Updating to latest tmux environment...";
        export IFS=",";
        for line in $(tmux showenv -t $(tmux display -p "#S") | tr "\n" ",");
        do
            if [[ $line == -* ]]; then
                unset $(echo $line | cut -c2-);
            else
                export $line;
            fi;
        done;
        unset IFS;
        echo "Done"
    }
fi'
fi
