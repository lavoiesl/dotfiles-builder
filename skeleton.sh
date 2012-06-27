#!/bin/bash

SKELETON_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function program_exists() {
  program="$1"
  [ -n "$program" ] && which "$program" >/dev/null
}

function realpath() {
  path="$1"
  # readlink of Mac is deficient, use ruby instead
  echo "require 'pathname'; puts Pathname.new('$path').realpath" | ruby 2>/dev/null
}

function skeleton_dump() {
  cd "$SKELETON_DIR/bashrc.d"

  for file in $(ls *); do
    content=$(. "$SKELETON_DIR/bashrc.d/$file")

    if [[ -n "$content" ]]; then
      echo "# $file"
      echo "$content"
      echo
    fi

  done
}

skeleton_dump
