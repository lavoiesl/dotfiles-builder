#!/bin/bash

SKELETON_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "${SKELETON_DIR}/lib.sh"

case "$1" in
    install)
        path="${2:-$HOME}"

        for file in $(find "${SKELETON_DIR}"/dotfiles -type f -depth 1); do
            cp "$file" "${path}/$(basename $file)"
        done

        for gen in $(find "${SKELETON_DIR}"/dotfiles -name gen.sh -type f -depth 2); do
            file="$(dirname "${gen}")"
            content=$(. "${gen}")
            [ -n "${content}" ] && echo "${content}" > "${path}/$(basename $file)"
        done
        ;;

    *)
        echo "Usage: $0 install [path]" >&2
        exit 255
        ;;
esac

