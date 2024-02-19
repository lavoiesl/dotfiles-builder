#!/bin/bash

if program_exists delta; then
  echo "delta --color-only"
elif program_exists diff-so-fancy; then
  echo "diff-so-fancy"
fi
