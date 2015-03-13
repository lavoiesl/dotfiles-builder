#!/bin/bash

config_dir="${DOTFILES_CONFIG_DIR}/ssh/config"

[[ -d "${config_dir}" ]] && find "${config_dir}" -type f -maxdepth 1 -exec cat '{}' \;

[[ -d "${config_dir}/hosts" ]] && find "${config_dir}/hosts" -type f -exec cat '{}' \;
