#!/bin/bash

if program_exists brew; then
    ruby_path="$(brew --prefix ruby)"

    if [ -d "${ruby_path}" ]; then
        echo "${ruby_path}/bin"
    fi
fi
