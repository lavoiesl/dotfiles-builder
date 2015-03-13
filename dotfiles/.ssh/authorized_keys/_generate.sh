#!/bin/bash

config_dir="${DOTFILES_CONFIG_DIR}/ssh/authorized_keys"

[[ -d "${config_dir}" ]] && find "${config_dir}" -type f -maxdepth 1 -exec cat '{}' \;
