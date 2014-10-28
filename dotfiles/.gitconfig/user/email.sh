#!/bin/bash

email="$(git config --global user.email)"

[ -z "${email}" ] && email="$(prompt_value "What is your email ?")"

echo "${email}"
