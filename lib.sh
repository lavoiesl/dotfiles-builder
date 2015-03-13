#!/bin/bash

##
# Determine if a program is in path, without any output.
#
# @uses which
# @param string executable name
# @returns success code
#
function program_exists() {
    local program="$1"

    [ -n "${program}" ] && which "${program}" >/dev/null
}

##
# Determine if a brew is installed.
#
# @uses brew
# @param string brew name
# @returns success code
# 
function brew_installed() {
    local brew="${1}"

    brew list -1 | grep -q "^${brew}$"
}

##
# Convert to fully qualified path, expanding ../, symlinks, etc.
# Readlink of Mac is deficient, use ruby instead.
#
# @uses ruby
# @param string any path (can be . and such)
# @outputs absolute path
#
function realpath() {
    local path="$1"

    echo "require 'pathname'; puts Pathname.new('${path}').realpath" | ruby 2>/dev/null
}

##
# Prompt the user with a question, supporting default value
# 
# @uses read
# @param string question
# @param string optional default value
# @outputs answer or default value
#
function prompt_value() {
    local prompt="${1} "
    local default="${2}"

    [[ -n "${default}" ]] && prompt="${prompt}(${default}) "

    read -p "${prompt}" reply

    [[ -z "${reply}" ]] && reply="${default}"

    if [[ -z "${reply}" ]]; then
        prompt_value "${1}" "${2}"
    else
        echo "${reply}"
    fi
}

##
# Prompt the user to confirm, default is yes
# 
# @uses read
# @param string question
# @returns 0 if yes, 1 if no
#
function confirm() {
    local prompt="${1}"

    read -p "${prompt} (Y/n) " reply

    [[ "${reply}" != "n" ]]
}

function get_config_var() {
    local var_name="${1}"
    local config_dir="${DOTFILES_CONFIG_DIR}/vars"
    local file="${config_dir}/${var_name}"

    if [[ -s "${file}" ]]; then
        cat "${file}"
    fi
}

function set_config_var() {
    local var_name="${1}"
    local value="${2}"
    local config_dir="${DOTFILES_CONFIG_DIR}/vars"
    local file="${config_dir}/${var_name}"

    [[ -d "${config_dir}" ]] || mkdir -p "${config_dir}"

    echo "${value}" > "${file}"
}

function ensure_config_var() {
    local var="${1}"
    local message="${2:-$var}"
    local default="${3:-}"

    value="$(get_config_var "${var}")"

    if [[ -z "${value}" ]]; then
        value="$(prompt_value "${message}" "${default}")"
        set_config_var "${var}" "${value}"
    fi
}

##
# Escape custom characters in a string
# WARNING: if \ is escaped, it must be the first
# Example: escape "ab'\c" '\' "'"   ===>  ab\'\\c 
# 
# @param string The string to be escaped
# @param char* All the characters to espace, multiple chars are specified as multiple params.
# @outputs Escaped string
#
function escape_chars() {
    local content="$1"
    shift

    for char in $@; do
        if [ "${char}" = '$' -o "${char}" = '\' ]; then
            char="\\${char}"
        fi
        content="$(echo "${content}" | sed -e "s/${char}/\\\\${char}/g")"
    done

    echo "${content}"
}

##
# Sort all files by their filename, independently of their folder
# Example: ls -1 /a/* /b/* | sort_by_filename
# 
# @input One path per line
# @outputs One path per line
function sort_by_filename() {
    while read filename; do
      echo "${filename}" | sed -E 's/^(.+)\/([^/]+)$/\2#\1\/\2/';
    done | sort -n | cut -d '#' -f 2
}

##
# cat a file. If it ends with .sh, execute it instead
# 
# @param string file path
# @outputs content
#
function cat_or_exec() {
    local file="${1}"

    if echo "${file}" | grep -q '\.sh$'; then
        . "${file}"
    else
        cat "${file}"
    fi
}


##
# Check if directory contains executable files
#
# @link http://stackoverflow.com/questions/4458120/unix-find-search-for-executable-files
# @uses find
# @returns 0 if contains, 1 if empty
#
function dir_has_executables() {
    local dir="${1}"

    [ -n "$(find -L "${dir}" -type f -perm '+111' -mindepth 1 -maxdepth 1)" ]
}

##
# Print all passed arguments in reverse
# 
# @param string* All the arguments to be printed
# @outputs One argument per line
#
function reverse_args() {
    local items=($@)

    for (( idx=${#items[@]}-1 ; idx>=0 ; idx-- )) ; do
        echo "${items[idx]}"
    done
}

