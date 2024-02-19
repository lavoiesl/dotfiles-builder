#!/bin/bash

if program_exists delta; then
  echo "delta --hyperlinks"
else
  echo "less -FRSX"
fi
