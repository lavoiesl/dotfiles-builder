#!/bin/bash

function rc_dump() {
    local shell="$1"

    cd "$SKELETON_DIR/rc"

    # sort by filename (ignoring directory)
    files=$(ls -1 *.sh $shell/*.sh | sed -E 's/^(.+)\/([^/]+)$/\2#\1\/\2/' | sort -n | cut -d '#' -f 2)

    for file in $files; do
        content=$(. "$file")

        if [[ -n "$content" ]]; then
            echo "# "$(echo "$file" | sed 's/^\.\///')
            echo "$content"
            echo
        fi
    done
}
