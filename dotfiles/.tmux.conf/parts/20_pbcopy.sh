#!/bin/bash

program_exists reattach-to-user-namespace && program_exists pbcopy && echo "bind y run-shell \"reattach-to-user-namespace -l zsh -c 'tmux show-buffer | pbcopy'\""
