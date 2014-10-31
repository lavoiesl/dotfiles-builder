#!/bin/bash

SKELETON_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "${SKELETON_DIR}/lib.sh"

case "$1" in
    install)
        path="${2:-$HOME}"

        for file in $(find "${SKELETON_DIR}"/dotfiles -mindepth 1 -maxdepth 1 -type f); do
            echo "$(basename $file)" >&2
            cp "$file" "${path}/$(basename $file)"
        done

        for gen in $(find "${SKELETON_DIR}"/dotfiles -mindepth 2 -maxdepth 2 -name gen.sh -type f); do
            file="$(dirname "${gen}")"
            echo "$(basename $file)" >&2
            content=$(. "${gen}")
            [ -n "${content}" ] && echo "${content}" > "${path}/$(basename $file)"
        done
        ;;

    *)
        echo "Usage: $0 install [path]" >&2
        exit 255
        ;;
esac

