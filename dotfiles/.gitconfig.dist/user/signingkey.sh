#!/bin/bash

signingkey="$(git config --global user.signingkey)"

if [ -z "$signingkey" ]; then
    if program_exists gpg && [ -n "$(gpg --list-secret-keys --with-colons | grep '^sec' | grep -oE '[A-F0-9]{10,}' | head -n1)" ]; then
        signingkey="$(gpg --list-secret-keys --with-colons | grep '^sec' | grep -oE '[A-F0-9]{10,}' | head -n1)"
    elif [ -x "/Applications/1Password.app/Contents/MacOS/op-ssh-sign" ] && [ -n "$(ssh-add -L | head -n1)" ]; then
        signingkey="$(ssh-add -L | head -n1 | awk '{print $1" "$2 }')"
    fi
fi

echo "${signingkey}"


