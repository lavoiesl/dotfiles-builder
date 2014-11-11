#!/bin/bash

function program_exists() {
    local program="$1"
    [ -n "$program" ] && which "$program" >/dev/null
}

function brew_installed() {
  local brew="${1}"
  brew list -1 | grep -q "^${brew}$"
}

function realpath() {
    local path="$1"
    # readlink of Mac is deficient, use ruby instead
    echo "require 'pathname'; puts Pathname.new('$path').realpath" | ruby 2>/dev/null
}

function prompt_value() {
  local prompt="$1 "
  local default="$2"

  [[ -n "$default" ]] && prompt="$prompt($default) "

  read -p "$prompt" reply

  [[ -z "$reply" ]] && reply="$default"

  if [[ -z "$reply" ]]; then
    prompt_value "$prompt" "$default"
    exit
  fi

  echo "$reply"
}

function confirm() {
  local prompt="$1"

  read -p "$prompt (Y/n) " reply

  [[ $reply != "n" ]]

  return $?
}

# WARNING: if \ is escaped, it must be the first
function escape() {
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

# Usage: ls -1 * | sort_by_filename
function sort_by_filename() {
  while read filename; do echo "${filename}" | sed -E 's/^(.+)\/([^/]+)$/\2#\1\/\2/'; done | sort -n | cut -d '#' -f 2
}

function cat_or_exec() {
  local file="${1}"

  if echo "${file}" | grep -q '\.sh$'; then
    . "${file}"
  else
    cat "${file}"
  fi
}
