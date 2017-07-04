#!/bin/bash

program_exists git || exit

gitconfig="${DOTFILES_INSTALL_PATH}/.gitconfig"

tmp="$(mktemp)"
if [ -e "${gitconfig}" ]; then
    cat "${gitconfig}" > "${tmp}"
fi

if ! git config -f "${tmp}" --get-all include.path ".gitconfig.dist" 2>&1 >/dev/null; then
    git config -f "${tmp}" --add include.path ".gitconfig.dist"
fi

cat "${tmp}"
rm "${tmp}"
