#!/bin/bash

if program_exists tmux; then
    ensure_config_var TMUX_AUTOSTART "Automatically start tmux on login (true/false):"
fi
