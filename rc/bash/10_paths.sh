#!/bin/bash

paths="$(. "${DOTFILES_DIR}/rc/common/paths.sh" | tr \"\\n\" ':' | sed s/:$//)"

echo_export_single_quote PATH "${paths}"
