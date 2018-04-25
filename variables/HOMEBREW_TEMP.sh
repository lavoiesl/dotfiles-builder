#!/bin/bash

if program_exists brew; then
    tmp_dir="$(brew --prefix)/tmp"
    [ -d "${tmp_dir}" ] || mkdir -p "${tmp_dir}"
    echo "${tmp_dir}"
fi
