#!/bin/bash

shell="${SHELL}"

echo "set-option -g default-shell $shell"

if program_exists reattach-to-user-namespace; then
    echo "set-option -g default-command \"reattach-to-user-namespace -l $shell\""
else
    echo "WARN: reattach-to-user-namespace is missing: brew install reattach-to-user-namespace"
fi
