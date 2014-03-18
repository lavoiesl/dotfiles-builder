#!/bin/bash

if [[ -d $HOME/.oh-my-zsh ]]; then
    echo "ZSH='$HOME/.oh-my-zsh'"
    echo 'ZSH_THEME="wedisagree"'
    echo 'COMPLETION_WAITING_DOTS="true"'

    echo 'plugins=('
        program_exists brew && echo brew
        program_exists composer && echo composer
        program_exists git && echo git
        program_exists php && echo symfony2
        program_exists ssh-agent && echo ssh-agent
        program_exists svn && echo svn
    echo ')'

    echo 'zstyle :omz:plugins:ssh-agent agent-forwarding on'
    echo 'source $ZSH/oh-my-zsh.sh'
fi

