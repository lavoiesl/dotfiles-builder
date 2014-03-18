#!/bin/bash

SKELETON_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function get_shell() {
    shell="$1"
    if [[ -z "$shell" ]]; then
        # shell of parent process
        shell=$(ps -p$PPID -o cmd="",comm="" 2>/dev/null | sed 's/^-//' | grep -oE '\w+' | head -n1)
    fi
    echo $shell
}

function skeleton_dump() {
    shell="$1"

    cd "$SKELETON_DIR/rc"

    find="*.sh"
    [ -n "$shell" -a -d "$shell" ] && find="$find $shell/*.sh"
    files=$(ls -1 $find | sed -E 's/^(.+)\/([^/]+)$/\2#\1\/\2/' | sort -n | cut -d '#' -f 2)

    for file in $files; do
        content=$(. "$file")

        if [[ -n "$content" ]]; then
            echo "# "$(echo "$file" | sed 's/^\.\///')
            echo "$content"
            echo
        fi

    done
}

. $SKELETON_DIR/lib.sh

case "$1" in
    dump)
        shell=$(get_shell $2)

        if [[ -n "$shell" ]]; then
            echo "Generating rc for $shell" >&2
        else
            echo "Generating generic rc" >&2
        fi

        skeleton_dump "$shell"
        ;;

    install)
        shell=$(get_shell $2)

        if [[ -n "$shell" ]]; then
            file="$HOME/.${shell}rc"

            echo "Generating $file" >&2
            skeleton_dump "$shell" > $file
        else
            echo "Unable to detect shell" >&2
            echo "Usage: $0 $1 [bash|zsh]" >&2
            exit 1
        fi
        ;;

    *)
        echo "Usage: $0 [dump|install]" >&2
        exit 255
        ;;
esac

