#!/bin/bash

gpgsshprogram="$(git config --global gpg.ssh.program)"

if [ -z "$gpgsshprogram" ]; then
    if [ -n "$(ssh-add -L | head -n1)" ] && [ -x "/Applications/1Password.app/Contents/MacOS/op-ssh-sign" ]; then
        echo "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
    fi
fi

echo "${gpgsshprogram}"
