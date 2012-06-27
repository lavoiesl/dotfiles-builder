#!/bin/bash

if program_exists tput && tput colors >/dev/null; then
  for color_prog in grep egrep fgrep; do
    if program_exists $color_prog; then
      echo "alias $color_prog='$color_prog --color=auto'"
    fi
  done
fi
