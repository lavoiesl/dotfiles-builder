#!/bin/bash

if program_exists go || [ -e "${HOME}/.dev/go" ]; then
    gopath="$(ensure_config_var "GOPATH" "GOPATH" "${HOME}")"
    echo "${gopath}"
fi
