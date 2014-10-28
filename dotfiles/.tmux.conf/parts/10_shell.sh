#!/bin/bash

shell="${SHELL}"

echo "set-option -g default-shell $shell"

program_exists reattach-to-user-namespace && echo "set-option -g default-command \"reattach-to-user-namespace -l $shell\""
