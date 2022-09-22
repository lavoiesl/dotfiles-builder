#!/bin/bash

if program_exists kubectl; then
  echo 'source <(kubectl completion bash)'
  echo 'complete -F __start_kubectl k'
fi
