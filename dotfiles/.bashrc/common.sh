#!/bin/bash

function rc_dump() {
    local shell="$1"

    echo "#!/usr/bin/env ${shell}"
    echo

    # sort by filename (ignoring directory)
    files=$(ls -1 {"${DOTFILES_DIR}","${DOTFILES_CONFIG_DIR}"}/rc/{$shell/,}*.sh 2>/dev/null | sort_by_filename)

    for file in $files; do
        echo " > $(basename $file)" >&2
        content=$(. "$file")

        if [[ -n "$content" ]]; then
            echo "# "$(echo "$file" | sed -e 's/^\.\///' -e "s|${HOME}|~|")
            echo "$content"
            echo
        fi
    done
}
