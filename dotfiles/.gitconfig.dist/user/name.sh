#!/bin/bash

name="$(git config -f "${DOTFILES_INSTALL_PATH}/.gitconfig" --includes user.name)"

[ -z "${name}" ] && name="$(prompt_value "What is your name ?")"

echo "${name}"
