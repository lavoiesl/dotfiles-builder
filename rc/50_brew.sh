#!/bin/bash

if program_exists brew; then
  echo 'eval $(brew shellenv)'
fi
