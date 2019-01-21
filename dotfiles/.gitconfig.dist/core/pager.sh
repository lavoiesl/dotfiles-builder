#!/bin/bash

if program_exists most; then
    echo most
else
    echo "less -FRSX"
fi
