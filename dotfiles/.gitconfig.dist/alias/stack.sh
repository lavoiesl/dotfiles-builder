#!/bin/sh

if program_exists gh && gh stack -v 2>/dev/null >&2; then
  echo "!gh stack"
fi
