#!/bin/sh

if program_exists git-chain; then
  echo "chain parent"
elif program_exists git-town; then
  echo "!sh -c \"git config git-town-branch.\$(git rev-parse --abbrev-ref HEAD).parent\""
fi
