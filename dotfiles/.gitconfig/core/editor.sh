#!/bin/bash

if program_exists vim; then
  which vim
  exit
fi

if program_exists vi; then
  which vi
  exit
fi

if program_exists nano; then
  which nano
  exit
fi
