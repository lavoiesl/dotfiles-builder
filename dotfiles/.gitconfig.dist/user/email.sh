#!/bin/bash

email="$(git config -f "${DOTFILES_INSTALL_PATH}/.gitconfig" --includes user.email)"

[ -z "${email}" ] && email="$(prompt_value "What is your email ?")"

echo "${email}"
