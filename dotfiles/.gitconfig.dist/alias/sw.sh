#!/bin/sh

if program_exists git-chain; then
  echo "chain switch"
elif program_exists git-town; then
  echo "town switch"
fi
