#!/bin/bash

function program_exists() {
    program="$1"
    [ -n "$program" ] && which "$program" >/dev/null
}

function realpath() {
    path="$1"
    # readlink of Mac is deficient, use ruby instead
    echo "require 'pathname'; puts Pathname.new('$path').realpath" | ruby 2>/dev/null
}
