#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for part in $(find "${DIR}/parts" -type f); do
    if echo "${part}" | grep -q '\.sh$'; then
        content="$(. "${part}")"
    else
        content="$(cat "${part}")"
    fi

    [ -n "${content}" ] && echo -e "\n# $(basename "${part}")\n${content}"
done

echo

for side in left right; do
    status=""

    for part in $(find "${DIR}/status-${side}" -type f); do
        if echo "${part}" | grep -q '\.sh$'; then
            content="$(. "${part}")"
        else
            content="$(cat "${part}")"
        fi

        [[ -n "${content}" ]] && status="${status} ${content}"
    done

    if [[ -n "${status}" ]]; then
        # Escape single-quotes and trim whitespace
        status=$(echo "${status}" | sed -e "s/'/\\'/g" -e 's/^ *//' -e 's/ *$//')
        echo "set -g status-${side} '${status}#[default]'"
    fi
done
