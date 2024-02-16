#!/bin/bash

if program_exists zoxide; then
    # https://github.com/ajeetdsouza/zoxide
    # For completions to work, the above line must be added after compinit is called. You may have to rebuild your completions cache by running rm ~/.zcompdump*; compinit.
    echo 'eval "$(zoxide init --cmd cd zsh)"'
fi
