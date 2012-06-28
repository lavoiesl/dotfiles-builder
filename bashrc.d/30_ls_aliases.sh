#!/bin/bash

switches="-F"

if program_exists tput && tput colors >/dev/null; then
  switches="${switches}C"
fi

echo "alias ls='ls ${switches}'"
echo "alias l='ls ${switches}'"
echo "alias la='ls ${switches}a'"
echo "alias ll='ls ${switches}l'"
echo "alias lal='ls ${switches}al'"
