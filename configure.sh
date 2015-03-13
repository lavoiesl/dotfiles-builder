#!/bin/bash

# Install path defaults to $HOME
# Usage: configure.sh [path]

export DOTFILES_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "${DOTFILES_DIR}/lib.sh"

DOTFILES_INSTALL_PATH="${1:-${DOTFILES_INSTALL_PATH:-${HOME}}}"

[ -d "${DOTFILES_INSTALL_PATH}" ] || mkdir -p "${DOTFILES_INSTALL_PATH}"

export DOTFILES_INSTALL_PATH="$(realpath "${DOTFILES_INSTALL_PATH}")"
export DOTFILES_CONFIG_DIR="${DOTFILES_INSTALL_PATH}/.dotfiles-config"

[ -d "${DOTFILES_CONFIG_DIR}" ] || mkdir "${DOTFILES_CONFIG_DIR}"

for configure in "${DOTFILES_DIR}/configure"/*.sh; do
    . "${configure}"
done
