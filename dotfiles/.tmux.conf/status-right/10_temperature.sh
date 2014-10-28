#!/bin/bash

if program_exists sensors; then
    echo '#[fg=red]#(sensors | grep -E "\(Core|CPU\)" | grep -oE "[0-9]+\.[0-9]+°" | head -n1)'
elif program_exists osx-cpu-temp; then
    echo '#[fg=red]#(osx-cpu-temp)'
fi
