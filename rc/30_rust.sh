#!/bin/bash

env_script="$HOME/.cargo/env"

if [ -f "$env_script" ]; then
    echo "source \"$env_script\""
fi