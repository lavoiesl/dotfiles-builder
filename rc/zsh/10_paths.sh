#!/bin/bash

echo "path=("
    . "${DOTFILES_DIR}/rc/common/paths.sh" | sed -e 's/^/    "/' -e 's/$/"/'
echo ")"
