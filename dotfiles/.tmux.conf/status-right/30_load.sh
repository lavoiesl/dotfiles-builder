#!/bin/bash

if program_exists uptime; then
    echo '#[fg=yellow]#(uptime | grep -oE "[0-9\., ]+$" | tr -d ",")'
elif [[ -e '/proc/loadavg' ]]; then
    echo '#[fg=yellow]#(cut -d " " -f 1-3 /proc/loadavg)'
fi
