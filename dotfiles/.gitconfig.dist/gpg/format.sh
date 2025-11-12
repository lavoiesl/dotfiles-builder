#!/bin/bash

gpgformat="$(git config --global gpg.format)"

if [ -z "$gpgformat" ]; then
    if [ -n "$(ssh-add -L | head -n1)" ] && [ -x "/Applications/1Password.app/Contents/MacOS/op-ssh-sign" ]; then
        echo "ssh"
    fi
fi

echo "${gpgformat}"
