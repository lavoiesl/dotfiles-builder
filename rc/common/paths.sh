#!/bin/bash

paths_dir="${DOTFILES_DIR}/paths"
config_dir="${DOTFILES_CONFIG_DIR}/paths"

default_paths=(
    /usr/local/sbin
    /usr/local/bin
    /usr/sbin
    /usr/bin
    /sbin
    /bin
)

paths=""

function prepend_path() {
    local path="${1}"

    # Test if dir exists, contains executable and not already in path
    if [ -n "${path}" -a -d "${path}" ] && dir_has_executables "${path}" && ! echo "${paths}" | grep -oE '[^:]+' | grep -q "^${path}\$"; then
        paths="${path}:${paths}"
    fi
}

# default POSIX paths
for path in $(reverse_args ${default_paths[@]}); do
    prepend_path "${path}"
done

# prepend current PATH in reverse order (to maintain original order)
for path in $(reverse_args $(echo "${PATH}" | grep -oE '[^:]+')); do
    prepend_path "${path}"
done

generators=""

# stock generators
if [[ -d "${paths_dir}" ]]; then
    generators="$(ls -1 "${paths_dir}"/*)"
fi

# custom generators
if [[ -d "${config_dir}" ]]; then
    generators="${generators}
$(ls -1 "${config_dir}"/*)"
fi

# prepend custom PATH in reverse order (to maintain original order)
if [ -n "${generators}" ]; then
    for gen in $(reverse_args "$(echo "${generators}" | sort_by_filename)"); do
        path=$(cat_or_exec "${gen}")
        for p in $path; do
            prepend_path "$p"
        done
    done
fi

# See http://stackoverflow.com/questions/11532157/unix-removing-duplicate-lines-without-sorting
echo $paths | grep -oE '[^:]+' | awk ' !x[$0]++'

