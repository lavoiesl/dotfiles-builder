#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for part in $(find "${DIR}/parts" -type f | sort); do
    content="$(cat_or_exec "${part}")"
    [ -n "${content}" ] && echo -e "\n# $(basename "${part}")\n${content}"
done

echo

for side in left right; do
    status=""

    for part in $(find "${DIR}/status-${side}" -type f | sort); do
        content="$(cat_or_exec "${part}")"
        [[ -n "${content}" ]] && status="${status} ${content}"
    done

    if [[ -n "${status}" ]]; then
        status="$(escape "${status}" "'" | sed -e 's/^ *//' -e 's/ *$//')"
        echo "set -g status-${side} '${status}#[default]'"
    fi
done
