#!/bin/bash

function rc_dump() {
    local shell="$1"

    echo "#!/usr/bin/env ${shell}"
    echo
    cd "$DOTFILES_DIR/rc"

    # sort by filename (ignoring directory)
    files=$(ls -1 *.sh $shell/*.sh | sort_by_filename)

    for file in $files; do
        echo " > $(basename $file)" >&2
        content=$(. "$file")

        if [[ -n "$content" ]]; then
            echo "# "$(echo "$file" | sed 's/^\.\///')
            echo "$content"
            echo
        fi
    done
}
