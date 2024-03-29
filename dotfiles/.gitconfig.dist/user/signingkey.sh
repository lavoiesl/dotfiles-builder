#!/bin/bash

signingkey="$(git config --global user.signingkey)"

[ -z "${signingkey}" ] && program_exists gpg && signingkey="$(gpg --list-secret-keys --with-colons | grep '^sec' | grep -oE '[A-F0-9]{10,}' | head -n1)"

echo "${signingkey}!"


