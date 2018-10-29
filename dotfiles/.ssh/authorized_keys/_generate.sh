#!/bin/bash

config_dir="${DOTFILES_CONFIG_DIR}/ssh/authorized_keys"

[[ -d "${config_dir}" ]] && find "${config_dir}" -maxdepth 1 -type f -exec cat '{}' \;
