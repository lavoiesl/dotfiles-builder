#!/bin/bash


if program_exists op && [[ -f "${HOME}/.config/op/plugins.sh" ]]; then
   echo "source '${HOME}/.config/op/plugins.sh'"
fi
