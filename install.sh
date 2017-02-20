#!/bin/bash

# Install path defaults to $HOME
# Usage: install.sh [path]

export DOTFILES_INSTALL_PATH="${1:-$HOME}"

export DOTFILES_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "${DOTFILES_DIR}/configure.sh"

# If file: copy
# If directory:
#   If directory/_generate.sh exists: output to file named like directory
#   else: recurse, creating directories
function recursive_install() {
    local dest_dir="${1}"
    local source_dir="${2}"
    local sub_dir="${3}"

    [ -d "${dest_dir}${sub_dir}" ] || mkdir -p "${dest_dir}${sub_dir}"
    cd "${source_dir}${sub_dir}"

    for file in `ls -1A`; do
        local dest_file="${dest_dir}${sub_dir}/${file}"
        local source_file="${source_dir}${sub_dir}/${file}"

        echo "${dest_file/$HOME/~}" >&2

        if [[ -d "${source_file}" ]]; then
            if [[ -f "${source_file}/_generate.sh" ]]; then
                content="$(. "${source_file}/_generate.sh")"
                [ -n "${content}" ] && echo "${content}" > "${dest_file}"
            else
                recursive_install "${dest_dir}" "${source_dir}" "${sub_dir}/${file}"
            fi
        else
            cp -p "${source_file}" "${dest_file}"
        fi
    done
}


recursive_install "${DOTFILES_INSTALL_PATH}" "${DOTFILES_CONFIG_DIR}/dotfiles"
