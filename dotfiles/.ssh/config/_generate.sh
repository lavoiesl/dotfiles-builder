#!/bin/bash

config_dir="${DOTFILES_CONFIG_DIR}/ssh/config"

[[ -d "${config_dir}" ]] && find "${config_dir}" -maxdepth 1 -type f -exec cat '{}' \;

[[ -d "${config_dir}/hosts" ]] && find "${config_dir}/hosts" -type f -exec cat '{}' \;

sock="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
if [ -e "${sock}" ]; then
    cat <<EOF
Host *
  IdentityAgent "${sock}"
EOF
fi
