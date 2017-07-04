#!/bin/bash

name="$(git config --global user.name)"

[ -z "${name}" ] && name="$(prompt_value "What is your name ?")"

echo "${name}"
