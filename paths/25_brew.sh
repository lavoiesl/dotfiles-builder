#!/bin/bash

if program_exists brew; then
    echo "$(brew --prefix)/bin"
fi
