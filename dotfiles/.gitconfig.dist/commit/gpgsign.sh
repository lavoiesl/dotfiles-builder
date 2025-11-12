#!/bin/bash

gpgsign="$(git config --global --bool --get commit.gpgsign)"

if [ -z "$gpgsign" ]; then
    if program_exists gpg && gpg --list-secret-keys --with-colons | grep -q '^fpr'; then
        gpgsign=true
    elif [ -n "$(ssh-add -L | head -n1)" ] && [ -x "/Applications/1Password.app/Contents/MacOS/op-ssh-sign" ]; then
        gpgsign=true
    fi
fi

echo "${gpgsign}"
