#!/bin/bash

# Install path defaults to $HOME
# Usage: configure.sh [path]

export DOTFILES_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "${DOTFILES_DIR}/lib.sh"

DOTFILES_INSTALL_PATH="${1:-${DOTFILES_INSTALL_PATH:-${HOME}}}"

[ -d "${DOTFILES_INSTALL_PATH}" ] || mkdir -p "${DOTFILES_INSTALL_PATH}"

export DOTFILES_INSTALL_PATH="$(realpath "${DOTFILES_INSTALL_PATH}")"
export DOTFILES_CONFIG_DIR="${DOTFILES_INSTALL_PATH}/.dotfiles-config"

if [ ! -d "${DOTFILES_CONFIG_DIR}" ]
then
    mkdir "${DOTFILES_CONFIG_DIR}"
    echo "First time dotfiles-builder is run."
    echo "You will need to import your configurations."
fi

for configure in "${DOTFILES_DIR}/configure"/*.sh; do
    . "${configure}"
done
