#!/bin/bash

gpgsign="$(git config --global --bool --get commit.gpgsign)"

if [ -z "$gpgsign" ] &&
    program_exists gpg &&
    gpg --list-secret-keys --with-colons | grep -q '^fpr'; then
    gpgsign=true
fi

echo "${gpgsign}"


