#!/bin/bash

if program_exists brew; then
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    echo ". `brew --prefix`/etc/bash_completion"
  fi
fi
