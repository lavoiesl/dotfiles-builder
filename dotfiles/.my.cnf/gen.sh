#!/bin/bash

function mysql_default() {
    local current="$(mysql --print-defaults | grep -oE -- "--${1}=[^ ]+" | sed "s/--${1}=//")"
    local message="${2}"
    local default="${3}"

    if [ -n "${current}" ]; then
        echo "${current}"
    else
        prompt_value "${message}" "${default}"
    fi
}

function mysql_test() {
    local config_file="${1}"

    mysql --defaults-extra-file="${config_file}" -e "SELECT 1" 2>/dev/null >/dev/null

    return $?
}

if program_exists mysql; then
    file="$(mktemp /tmp/.my.cnf.XXXXXX)"

    echo '[client]' > "${file}"
    echo "host=\"$(mysql_default host "MySQL host" "localhost")\"" >> "${file}"
    echo "user=\"$(mysql_default user "MySQL user" "root")\"" >> "${file}"
    echo "password=\"$(mysql_default password "MySQL password" "root")\"" >> "${file}"

    if mysql_test "${file}"; then
        cat "${file}"
    else
        echo "WARNING: Unable to connect to MySQL using provided options, skipping .my.cnf generation." >&2
    fi

    rm "${file}"
fi
