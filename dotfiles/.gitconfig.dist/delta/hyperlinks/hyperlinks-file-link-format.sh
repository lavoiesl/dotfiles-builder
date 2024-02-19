#!/bin/bash

if program_exists code; then
  echo "vscode://file/{path}:{line}"
fi
