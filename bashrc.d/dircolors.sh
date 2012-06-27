#!/bin/bash

# enable color support of ls and also add handy aliases
if program_exists dircolors && program_exists tput && tput colors >/dev/null; then

  if [[ -r ~/.dircolors ]]; then
    dircolors -b ~/.dircolors
  else
    dircolors -b
  fi
fi
